# ---------- BUILD ----------
FROM mcr.microsoft.com/dotnet/sdk:9.0 AS build
WORKDIR /src

# Copiar solución
COPY *.sln .

# Copiar proyectos
COPY Ecommerce.API ./Ecommerce.API
COPY Ecommerce.Application ./Ecommerce.Application
COPY Ecommerce.Domain ./Ecommerce.Domain
COPY Ecommerce.Infrastructure ./Ecommerce.Infrastructure

# Restaurar dependencias
RUN dotnet restore

# Publicar SOLO la API
RUN dotnet publish Ecommerce.API/Ecommerce.API.csproj \
    -c Release \
    -o /app/publish \
    --no-restore

# ---------- RUNTIME ----------
FROM mcr.microsoft.com/dotnet/aspnet:9.0
WORKDIR /app

ENV ASPNETCORE_URLS=http://localhost:8585
EXPOSE 8585

COPY --from=build /app/publish .

ENTRYPOINT ["dotnet", "Ecommerce.API.dll"]

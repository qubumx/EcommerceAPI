# ---------- BUILD ----------
FROM mcr.microsoft.com/dotnet/sdk:9.0 AS build
WORKDIR /src

# Copiar archivos de proyecto (.csproj) para restaurar dependencias
COPY *.sln .
COPY Ecommerce.API/*.csproj ./Ecommerce.API/
COPY Ecommerce.Application/*.csproj ./Ecommerce.Application/
COPY Ecommerce.Domain/*.csproj ./Ecommerce.Domain/
COPY Ecommerce.Infrastructure/*.csproj ./Ecommerce.Infrastructure/

# Restaurar dependencias (aprovecha la caché de Docker)
RUN dotnet restore

# Copiar el resto del código fuente
COPY Ecommerce.API ./Ecommerce.API
COPY Ecommerce.Application ./Ecommerce.Application
COPY Ecommerce.Domain ./Ecommerce.Domain
COPY Ecommerce.Infrastructure ./Ecommerce.Infrastructure

# Publicar SOLO la API
# Se especifica el directorio de trabajo para que la ruta de publicación sea más limpia
WORKDIR /src/Ecommerce.API
RUN dotnet publish -c Release -o /app/publish --no-restore

# ---------- RUNTIME ----------
FROM mcr.microsoft.com/dotnet/aspnet:9.0
WORKDIR /app

ENV ASPNETCORE_URLS=http://localhost:8585
EXPOSE 8585

COPY --from=build /app/publish .

ENTRYPOINT ["dotnet", "Ecommerce.API.dll"]

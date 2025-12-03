FROM mcr.microsoft.com/dotnet/sdk:9.0 AS build
WORKDIR /src

COPY ["TrenRezervasyon.sln", "./"]
COPY ["TrenRezervasyon.API/TrenRezervasyon.API.csproj", "TrenRezervasyon.API/"]
COPY ["TrenRezervasyon.Core/TrenRezervasyon.Core.csproj", "TrenRezervasyon.Core/"]
COPY ["TrenRezervasyon.Service/TrenRezervasyon.Service.csproj", "TrenRezervasyon.Service/"]


RUN dotnet restore


COPY . .


WORKDIR "/src/TrenRezervasyon.API"
RUN dotnet publish -c Release -o /app/publish


FROM mcr.microsoft.com/dotnet/aspnet:9.0
WORKDIR /app
COPY --from=build /app/publish .


ENV ASPNETCORE_URLS=http://+:8080
EXPOSE 8080

ENTRYPOINT ["dotnet", "TrenRezervasyon.API.dll"]
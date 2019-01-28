FROM microsoft/dotnet:2.2-sdk-alpine as build
COPY . ./docker-test/
WORKDIR /docker-test/API/
RUN dotnet build -c Release -o ../deploy

FROM microsoft/dotnet:2.2-aspnetcore-runtime-alpine as runtime
COPY --from=build /docker-test/deploy /app
WORKDIR /app
EXPOSE 5000:5000
ENTRYPOINT [ "dotnet", "API.dll" ]

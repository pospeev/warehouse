# README

## Run the app with docker locally:

To build the container and all its dependencies run
```
docker-compose build
```

Then setup the database:
```
docker-compose run --rm app rake db:setup
```
If everything went fine you should be able to run
```
docker-compose up
```

You can find the swagger docs on [http://localhost:3000/swagger_doc](http://localhost:3000/swagger_doc)
Put the URL into some REST client like [insomnia](https://insomnia.rest/) or browse it via [Swagger UI](https://petstore.swagger.io/#/)

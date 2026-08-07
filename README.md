# SnacksCorner
A Spring web application built with Maven, Spring MVC, and Hibernate.

## Render deployment
This project is prepared to deploy on Render using Docker.

### Included files
- `Dockerfile` — builds the WAR and runs Tomcat 11
- `.dockerignore` — excludes local build artifacts from the Docker context
- `render.yaml` — optional Render service definition for Docker deployment

### Environment variables
The application uses environment variables for database configuration. Set these on Render or in your environment:
- `DB_URL` — JDBC URL for MySQL (default: `jdbc:mysql://localhost:3306/snackcornerdb`)
- `DB_USERNAME` — database username (default: `root`)
- `DB_PASSWORD` — database password (default: `6967`)
- `HIBERNATE_DIALECT` — Hibernate SQL dialect (default: `org.hibernate.dialect.MySQL8Dialect`)
- `HIBERNATE_SHOW_SQL` — enable SQL logging (default: `false`)
- `HIBERNATE_DDL_AUTO` — schema generation strategy (default: `validate`)

Example Render MySQL URL:

```
jdbc:mysql://<HOST>:<PORT>/snackcornerdb
```

### Local development with Docker Compose
Run the app and MySQL locally:

```bash
docker compose up --build
```

The app will be available at `http://localhost:8080`.

### Deploy on Render
1. Push this repository to GitHub.
2. Create a new Render Web Service.
3. Choose `Docker` as the environment.
4. Set the service to use the `Dockerfile` in the repo root.
5. Add `DB_URL`, `DB_USERNAME`, and `DB_PASSWORD` as environment variables.
6. Deploy.

### Local build
This project requires Java 17 for local builds because it uses Spring 6.

To build locally with JDK 17 installed:

```bash
mvn clean package
```

To run locally via Docker:

```bash
docker build -t snackscorner .
docker run -p 8080:8080 \
  --env DB_URL="jdbc:mysql://localhost:3306/snackcornerdb" \
  --env DB_USERNAME=root \
  --env DB_PASSWORD=6967 \
  snackscorner
```

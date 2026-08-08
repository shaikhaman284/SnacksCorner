# SnacksCorner
A Spring web application built with Maven, Spring MVC, and Hibernate.

## Deployment guide
For a complete deployment guide, see `DEPLOYMENT.md`.

## Render deployment
This project is prepared to deploy on Render using Docker.

### Included files
- `Dockerfile` — builds the WAR and runs Tomcat 11
- `.dockerignore` — excludes local build artifacts from the Docker context
- `render.yaml` — optional Render service definition for Docker deployment

### Environment variables
The application uses environment variables for database configuration. Set these on Render or in your environment:
- `DB_URL` — JDBC URL for the database (default: `jdbc:postgresql://localhost:5432/snackcornerdb`)
- `DATABASE_URL` — alternate JDBC URL (Render typically provides this for Postgres)
- `DB_USERNAME` — database username (default: `postgres`)
- `DB_PASSWORD` — database password (default: `postgres`)
- `HIBERNATE_DIALECT` — Hibernate SQL dialect (default: `org.hibernate.dialect.PostgreSQLDialect`)
- `HIBERNATE_SHOW_SQL` — enable SQL logging (default: `false`)
- `HIBERNATE_DDL_AUTO` — schema generation strategy (default: `validate`)

Example Render PostgreSQL URL:

```
jdbc:postgresql://<HOST>:<PORT>/snackcornerdb
```

> On Render, do not leave `DB_URL` as a placeholder; use the actual `DATABASE_URL` or Postgres connection string provided by Render.
> You must configure the actual database host, port, username, and password in the Render environment.

### Local development with Docker Compose
Run the app and local database with Docker Compose:

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
  --env DB_URL="jdbc:postgresql://localhost:5432/snackcornerdb" \
  --env DB_USERNAME=postgres \
  --env DB_PASSWORD=postgres \
  snackscorner
```

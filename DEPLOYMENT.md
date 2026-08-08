# SnacksCorner Deployment Guide

This guide describes how to deploy SnacksCorner on both local Docker and Render.

## 1. Project requirements
- Java 17
- Maven
- Docker
- A PostgreSQL database (local or Render managed database)

## 2. Project files for deployment
- `Dockerfile` — builds the WAR and runs the app in Tomcat 11
- `.dockerignore` — excludes build artifacts from the Docker context
- `docker-compose.yml` — local Docker Compose stack with PostgreSQL + app
- `render.yaml` — Render web service configuration for Docker deployment
- `src/main/webapp/WEB-INF/spring-dispatcher-servlet.xml` — loads database config from environment variables

## 3. Database environment variables
The application supports these variables:

- `DB_URL` — primary JDBC URL (PostgreSQL)
- `DATABASE_URL` — fallback JDBC URL if `DB_URL` is not set
- `DB_USERNAME` — database username
- `DB_PASSWORD` — database password
- `HIBERNATE_DIALECT` — Hibernate dialect (default: `org.hibernate.dialect.PostgreSQLDialect`)
- `HIBERNATE_SHOW_SQL` — whether to log SQL statements (default: `false`)
- `HIBERNATE_DDL_AUTO` — schema generation strategy (`validate` by default)

### Example JDBC URL

```text
jdbc:postgresql://<HOST>:<PORT>/snackcornerdb
```

> Use your actual database host and port values. Do not keep placeholder values in production.

## 4. Local development with Docker Compose
This repository includes a `docker-compose.yml` that starts a local database and the app. For Render deployments use the managed PostgreSQL service (see below).

Run:

```bash
docker compose up --build
```

Then open:

```text
http://localhost:8080
```

### Local database credentials
Adjust `docker-compose.yml` for PostgreSQL if you run locally; example credentials often are:
- DB user: `postgres`
- DB password: `postgres`
- DB name: `snackcornerdb`

These values can be configured in `docker-compose.yml` for local testing.

## 5. Building locally
If you prefer not to use Docker Compose, build the app locally with JDK 17:

```bash
mvn clean package
```

Run the app in Docker with environment variables:

```bash
docker build -t snackscorner .
docker run -p 8080:8080 \
  --env DB_URL="jdbc:postgresql://localhost:5432/snackcornerdb" \
  --env DB_USERNAME=postgres \
  --env DB_PASSWORD=postgres \
  snackscorner
```

## 6. Render Docker deployment
Render supports Docker deployments using a `Dockerfile`.

### Steps
1. Push this repository to GitHub.
2. Create a new Render Web Service.
3. Select `Docker` for environment.
4. Connect your GitHub repository.
5. Set `Dockerfile` as the build path.
6. Configure environment variables:
   - `DB_URL` or `DATABASE_URL`
   - `DB_USERNAME`
   - `DB_PASSWORD`
   - `HIBERNATE_DIALECT` (optional)
   - `HIBERNATE_SHOW_SQL` (optional)
   - `HIBERNATE_DDL_AUTO` (optional)
7. Deploy.

### Notes for Render
- Render assigns a `PORT` environment variable automatically.
- The app uses that `PORT` to configure Tomcat.
- Do not hardcode database host or password in source control.

## 7. Render managed database
If you use Render's managed PostgreSQL database, Render will provide a `DATABASE_URL` environment variable. Use that, or set `DB_URL` to the connection string provided by Render. It may look like:

```text
jdbc:postgresql://<db-host>:<port>/<database-name>
```

Then configure:
- `DB_USERNAME`
- `DB_PASSWORD`

## 8. Troubleshooting
### `Communications link failure`
This means the app cannot connect to the PostgreSQL instance.

Check:
- `DB_URL`/`DATABASE_URL` are correct
- database host and port are reachable from Render
- credentials are correct
- the database service is running

### Render port issues
If Render logs say a new primary port was detected, make sure the app is using the `PORT` environment variable.

This repository already updates Tomcat at startup using `PORT`.

## 9. Final verification
Deploy the app and confirm that the web app loads.

If the app still cannot connect to the database, verify the database connection directly from a local client or Render shell.

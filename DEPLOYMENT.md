# SnacksCorner Deployment Guide

This guide describes how to deploy SnacksCorner on both local Docker and Render.

## 1. Project requirements
- Java 17
- Maven
- Docker
- A MySQL-compatible database (local or Render managed database)

## 2. Project files for deployment
- `Dockerfile` — builds the WAR and runs the app in Tomcat 11
- `.dockerignore` — excludes build artifacts from the Docker context
- `docker-compose.yml` — local Docker Compose stack with MySQL + app
- `render.yaml` — Render web service configuration for Docker deployment
- `src/main/webapp/WEB-INF/spring-dispatcher-servlet.xml` — loads database config from environment variables

## 3. Database environment variables
The application supports these variables:

- `DB_URL` — primary JDBC URL for MySQL
- `DATABASE_URL` — fallback JDBC URL if `DB_URL` is not set
- `DB_USERNAME` — database username
- `DB_PASSWORD` — database password
- `HIBERNATE_DIALECT` — Hibernate dialect (default: `org.hibernate.dialect.MySQLDialect`)
- `HIBERNATE_SHOW_SQL` — whether to log SQL statements (default: `false`)
- `HIBERNATE_DDL_AUTO` — schema generation strategy (`validate` by default)

### Example JDBC URL

```text
jdbc:mysql://<HOST>:<PORT>/snackcornerdb
```

> Use your actual database host and port values. Do not keep placeholder values in production.

## 4. Local development with Docker Compose
This repository includes a `docker-compose.yml` that starts a MySQL database and the app.

Run:

```bash
docker compose up --build
```

Then open:

```text
http://localhost:8080
```

### Local database credentials
- DB user: `root`
- DB password: `rootpassword`
- DB name: `snackcornerdb`

These values are configured in `docker-compose.yml`.

## 5. Building locally
If you prefer not to use Docker Compose, build the app locally with JDK 17:

```bash
mvn clean package
```

Run the app in Docker with environment variables:

```bash
docker build -t snackscorner .
docker run -p 8080:8080 \
  --env DB_URL="jdbc:mysql://localhost:3306/snackcornerdb" \
  --env DB_USERNAME=root \
  --env DB_PASSWORD=6967 \
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
If you use Render's managed MySQL database, set `DB_URL` to the connection string provided by Render. It may look like:

```text
jdbc:mysql://<db-host>:<port>/<database-name>
```

Then configure:
- `DB_USERNAME`
- `DB_PASSWORD`

## 8. Troubleshooting
### `Communications link failure`
This means the app cannot connect to the MySQL instance.

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

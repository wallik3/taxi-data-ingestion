# Build a temporary postgres database which will be forwarded to https://localhost:5432 (in background process)
# Replace flag -d to -it if you want no-background process
# Use this when you want to open pg database for dev purpose
docker run -d \ 
  --name tmp-postgres \
  -e POSTGRES_USER=root \
  -e POSTGRES_PASSWORD=root \
  -e POSTGRES_DB=ny_taxi \
  -v $(pwd)/docker/postgres-data:/var/lib/postgresql \
  -p 5432:5432 \
  postgres:18

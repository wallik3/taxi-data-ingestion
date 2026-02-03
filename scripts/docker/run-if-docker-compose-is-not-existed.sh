# Without docker compose (A multi-container application in the shared network), you can to create a 3 containers seperately like this
# Ref : https://github.com/alexeygrigorev/workshops/tree/main/dezoomcamp-docker


# Set network which these 3 containers will be shared
# Why: When the pgadmin container connects to port 5432, the request originates from the shared Docker network, not from localhost where it was started.
docker network create pg-network

# 1. Run "Container" PostgreSQL on the network
docker run -it \
  -e POSTGRES_USER="root" \
  -e POSTGRES_PASSWORD="root" \
  -e POSTGRES_DB="ny_taxi" \
  -v ny_taxi_postgres_data:/var/lib/postgresql \
  -p 5432:5432 \
  --network=pg-network \
  --name pgdatabase \
  postgres:18 # Online Image from Docker Repo

# 2. In another terminal, run Container "pgAdmin" on the same network
docker run -it \
  -e PGADMIN_DEFAULT_EMAIL="admin@admin.com" \
  -e PGADMIN_DEFAULT_PASSWORD="root" \
  -v pgadmin_data:/var/lib/pgadmin \
  -p 8085:80 \
  --network=pg-network \
  --name pgadmin \
  dpage/pgadmin4 # Online Image from Docker Repo 


# Build custom image
docker build -f ../../Dockerfile -t taxi_ingest:v001 .

# 3. Run Container "taxi_ingest"
docker run -it \
  --network=pg-network \
  taxi_ingest:v001 \
    --pg-user=root \
    --pg-pass=root \
    --pg-host=pgdatabase \
    --pg-port=5432 \
    --pg-db=ny_taxi \
    --target-table=yellow_taxi_trips_2021_2 \
    --year=2021 \
    --month=2 \
    --chunksize=100000
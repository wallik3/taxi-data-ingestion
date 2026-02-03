from pydantic_settings import BaseSettings, SettingsConfigDict


class Settings(BaseSettings):
    # Postgres
    postgres_user: str
    postgres_password: str
    postgres_db: str
    postgres_port: int = 5432

    # pgAdmin
    pgadmin_email: str
    pgadmin_password: str
    pgadmin_port: int = 8085

    model_config = SettingsConfigDict(
        env_file=".env",
        env_file_encoding="utf-8",
        case_sensitive=False,  # POSTGRES_USER → POSTGRES_USER
    )

    @property
    def postgres_url(self) -> str:
        return (
            f"postgresql+psycopg2://"
            f"{self.postgres_user}:{self.postgres_password}"
            f"@localhost:{self.postgres_port}/{self.postgres_db}"
        )


settings = Settings()
import Config

config :pg_helper, PgHelper.Repo,
  database: System.get_env("DATALAKE_DB"),
  username: System.get_env("DATALAKE_USERNAME"),
  password: System.get_env("DATALAKE_PASSWORD"),
  hostname: System.get_env("DATALAKE_HOSTNAME"),
  pool_size: 1

config :pg_helper,
  ecto_repos: [PGHelper.Repo]


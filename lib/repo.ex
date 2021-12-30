defmodule PgHelper.Repo do
  use Ecto.Repo,
    otp_app: :pg_helper,
    adapter: Ecto.Adapters.Postgres

  def init(_type, config) do
    config =
      Keyword.put(config, :database, System.get_env("DATALAKE_USERNAME"))
      |> Keyword.put(:username, System.get_env("DATALAKE_USERNAME"))
      |> Keyword.put(:password, System.get_env("DATALAKE_PASSWORD"))
      |> Keyword.put(:hostname, System.get_env("DATALAKE_HOSTNAME"))

    {:ok, config}
  end
end


defmodule PgHelper do
  @doc """
  Starts the Postgres connection
  """
  def init_db(), do: PgHelper.Repo.start_link()
end

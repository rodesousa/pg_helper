defmodule PgHelper.MixProject do
  use Mix.Project

  def project do
    [
      app: :pg_helper,
      version: "0.1.0",
      elixir: "~> 1.13",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:postgrex, ">=0.0.0"},
      {:ecto, "~> 3.7"},
      {:ecto_psql_extras, "~> 0.7"},
      {:ecto_sql, "~> 3.0"},

    ]
  end
end

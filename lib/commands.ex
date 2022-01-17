defmodule PgHelper.Commands do
  @doc """
  Documentation from https://github.com/pawurb/ecto_psql_extras

  This command provides information on the efficiency of the buffer cache, for both index reads (index hit rate) as well as table reads (table hit rate). A low buffer cache hit ratio can be a sign that the Postgres instance is too small for the workload.

  By default the ASCII table is displayed. Alternatively you can return the raw query results:

  # Examples

      iex> cache_hit(format: :raw)
      %Postgrex.Result{
        columns: ["name", "ratio"],
        command: :select,
        connection_id: 15744,
        messages: [],
        num_rows: 2,
        rows: [
          ["index hit rate", #Decimal<0.99581498598930092070>],
          ["table hit rate", #Decimal<0.86705984200844064495>]
        ]
      }
  """
  def cache_hit(args \\ []) do
    EctoPSQLExtras.cache_hit(PgHelper.Repo, args)
  end

  def index_hit(args \\ []) do
    EctoPSQLExtras.index_cache_hit(PgHelper.Repo, args)
  end

  def table_hit(args \\ []) do
    EctoPSQLExtras.table_cache_hit(PgHelper.Repo, args)
  end

  def diagnose(args \\ []) do
    EctoPSQLExtras.diagnose(PgHelper.Repo, args)
  end

  @doc """
  Documentation from https://github.com/pawurb/ecto_psql_extras

  This method displays values for selected PostgreSQL settings. You can compare them with settings recommended by PGTune and tweak values to improve performance.
  """
  def db_settings() do
    EctoPSQLExtras.diagnose(PgHelper.Repo)
  end

  def index_usage() do
    EctoPSQLExtras.diagnose(PgHelper.Repo)
  end

  def query(raw_query) do
    Ecto.Adapters.SQL.query!(PgHelper.Repo, raw_query)
  end

  def shared_buffers() do
    query("show shared_buffers")
  end

  def show_tables do
    """
    SELECT *
    FROM pg_catalog.pg_tables
    WHERE schemaname != 'pg_catalog' AND 
    schemaname != 'information_schema';
    """
    |> query
  end

  def describe_table(table) do
    """
    SELECT 
    table_name, 
    column_name, 
    data_type 
    FROM 
    information_schema.columns
    WHERE 
    table_name = '#{table}';
    """
    |> query
  end

  @doc """
  Find statistics about the queries tracked by running
  source: http://www.louisemeta.com/blog/pg-stat-statements/
  """
  def pg_stat_statements_statistic do
    """
    SELECT total_time, min_time, max_time, mean_time, calls, query
    FROM pg_stat_statements
    ORDER BY mean_time DESC
    LIMIT 100;
    """
    |> query
  end

  def percent_of_times_index_used do
    """
    SELECT
    relname,
    100 * idx_scan / (seq_scan + idx_scan) percent_of_times_index_used,
    n_live_tup rows_in_table
    FROM
    pg_stat_user_tables
    WHERE
    seq_scan + idx_scan > 0
    ORDER BY
    n_live_tup DESC;

    """
  end
end

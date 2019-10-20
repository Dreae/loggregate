defmodule LoggregateWeb.SearchController do
  use LoggregateWeb, :controller
  import Ecto.Query
  alias Loggregate.{Repo, LogEntry, LogSearch}
  alias Loggregate.ServerMapping.ServerMapping

  def index(conn, %{"query" => query}) do
    query = from e in LogEntry, where: ^LogSearch.build_search_conditions(query), join: s in ServerMapping, on: s.server_id == fragment("(log_data -> 'server')::integer")
    results = Repo.all(from [e, s] in query, select: {e.timestamp, e.log_data, s.server_name})
    render(conn, "index.html", results: results)
  end

  def index(conn, _params) do
    query = from e in LogEntry, join: s in ServerMapping, on: s.server_id == fragment("(log_data -> 'server')::integer")
    results = Repo.all(from [e, s] in query, select: {e.timestamp, e.log_data, s.server_name})
    render(conn, "index.html", results: results)
  end
end

defmodule LoggregateWeb.SearchController do
  use LoggregateWeb, :controller
  import Ecto.Query
  alias Loggregate.{Repo, LogEntry, LogSearch}

  def index(conn, %{"query" => query}) do
    results = Repo.all(from LogEntry, where: ^LogSearch.build_search_conditions(query))
    render(conn, "index.html", results: results)
  end

  def index(conn, _params) do
    results = Repo.all(from LogEntry)
    render(conn, "index.html", results: results)
  end
end

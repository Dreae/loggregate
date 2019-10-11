defmodule LoggregateWeb.PageController do
  use LoggregateWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end

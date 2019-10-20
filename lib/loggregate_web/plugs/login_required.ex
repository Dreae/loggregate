defmodule Loggregate.Plugs.LoginRequired do
  use LoggregateWeb, :controller

  def init(_params) do

  end

  def call(conn, _params) do
    if conn.assigns[:user] == nil do
      conn
      |> put_flash(:info, "You must be logged in.")
      |> redirect(to: Routes.page_path(conn, :index))
    end
    conn
  end
end

defmodule LoggregateWeb.PageController do
  use LoggregateWeb, :controller
  alias Loggregate.Accounts

  def index(conn, _params) do
    render(conn, "index.html")
  end

  def do_login(conn, %{"username" => username, "password" => password}) do
    user = Accounts.get_by_username(username)
    cond do
      user == nil ->
        conn
        |> put_flash(:error, "Username or password incorrect")
        |> render("index.html")
      Argon2.verify_pass(password, user.password) == false ->
        conn
        |> put_flash(:error, "Username or password incorrect")
        |> render("index.html")
      true ->
        conn
        |> put_session(:username, username)
        |> redirect(to: Routes.search_path(conn, :index))
    end
  end
end

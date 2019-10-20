defmodule LoggregateWeb.Plugs.GetUser do
  use LoggregateWeb, :controller
  alias Loggregate.Accounts

  def init(_params) do

  end

  def call(conn, _params) do
    username = get_session(conn, :username)
    if username != nil do
      case Accounts.get_by_username(username) do
        %Loggregate.Accounts.User{} = user ->
          assign(conn, :user, user)
        _ ->
          conn
      end
    else
      conn
    end
  end
end

defmodule LoggregateWeb.Router do
  use LoggregateWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug LoggregateWeb.Plugs.GetUser
  end

  pipeline :authenticate do
    plug :browser
    plug Loggregate.Plugs.LoginRequired
  end

  scope "/", LoggregateWeb do
    pipe_through :browser

    get "/", PageController, :index
    post "/login", PageController, :do_login
  end

  scope "/dashboard", LoggregateWeb do
    pipe_through :authenticate

    get "/", SearchController, :index
  end

  # Other scopes may use custom stacks.
  # scope "/api", LoggregateWeb do
  #   pipe_through :api
  # end
end

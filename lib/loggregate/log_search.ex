defmodule Loggregate.LogSearch do
  import Ecto.Query
  alias Loggregate.LikeQuery

  def search_line(search_term) do
    dynamic(fragment("(to_tsvector('english', log_data ->> 'line') @@ plainto_tsquery('english', ?))", ^search_term))
  end

  def search_message(search_term) do
    dynamic(fragment("(to_tsvector('english', log_data ->> 'message') @@ plainto_tsquery('english', ?))", ^search_term))
  end

  def search_server(server_id) do
    dynamic(fragment("(jsonb_exists(log_data -> 'server', ?))", ^server_id))
  end

  def search_type(type) do
    dynamic(fragment("(jsonb_exists(log_data -> 'type', ?))", ^type))
  end

  def search_cvar(cvar) do
    dynamic(ilike(fragment("log_data -> 'cvar' ->> 'name'"), ^"%#{LikeQuery.like_sanitize(cvar)}%"))
  end

  def search_chat_name(name) do
    dynamic(ilike(fragment("log_data -> 'from' ->> 'name'"), ^"%#{LikeQuery.like_sanitize(name)}%") or fragment("to_tsvector('english', log_data -> 'from' ->> 'name') @@ plainto_tsquery('english', ?)", ^name))
  end

  def search_chat_steamid(steamid) do
    dynamic(ilike(fragment("log_data -> 'from' ->> 'steamid'"), ^"%#{LikeQuery.like_sanitize(steamid)}%"))
  end

  def build_search_conditions(search_string) do
    {opts, args, _} = OptionParser.parse(OptionParser.split(search_string), strict: [type: :string, cvar: :string, server: :string, name: :string, steamid: :string])
    conditions = true
    conditions = unless opts[:cvar] == nil do
      dynamic(^search_cvar(opts[:cvar]) and ^conditions)
    else
      conditions
    end

    conditions = unless opts[:server] == nil do
      dynamic(^search_server(opts[:server]) and ^conditions)
    else
      conditions
    end

    conditions = unless opts[:name] == nil do
      dynamic(^search_chat_name(opts[:name]) and ^conditions)
    else
      conditions
    end

    conditions = unless opts[:steamid] == nil do
      dynamic(^search_chat_steamid(opts[:steamid]) and ^conditions)
    else
      conditions
    end

    line_search = Enum.join(args, " ")
    conditions = unless line_search == "" do
      dynamic(^search_line(line_search) or ^search_message(line_search) and ^conditions)
    else
      conditions
    end

    conditions
  end
end

defmodule Loggregate.Repo.Migrations.IndexLogData do
  use Ecto.Migration

  def change do
    execute "CREATE EXTENSION pg_trgm", "DROP EXTENSION pg_trgm"
    create index("log_entries", [:timestamp])
    create index("log_entries", ["to_tsvector('english', log_data ->> 'message')"], using: "GIN")
    create index("log_entries", ["to_tsvector('english', log_data ->> 'line')"], using: "GIN")
    create index("log_entries", ["(log_data -> 'server')"], using: "GIN")
    create index("log_entries", ["(log_data -> 'type')"], using: "GIN")
    create index("log_entries", ["(log_data -> 'from' ->> 'name') gist_trgm_ops"], using: "GIST")
    create index("log_entries", ["to_tsvector('english', log_data -> 'from' ->> 'name')"], using: "GIN")
    create index("log_entries", ["(log_data -> 'from' ->> 'steamid') gist_trgm_ops"], using: "GIST")
    create index("log_entries", ["(log_data -> 'cvar' ->> 'name') gist_trgm_ops"], using: "GIST")
  end
end

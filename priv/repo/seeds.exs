# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Loggregate.Repo.insert!(%Loggregate.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.
alias Loggregate.{LogEntry, ServerMapping, Repo}
%LogEntry{} |> LogEntry.changeset(%{timestamp: DateTime.utc_now(), log_data: %{line: "\"Dreae<8><STEAM_0:1:123><TERRORIST>\" say \"Hello world\"", message: "Hello world", server: "test", type: "chat", from: %{name: "Dreae", steamid: "STEAM_0:1:123", team: false}}}) |> Repo.insert!()
%LogEntry{} |> LogEntry.changeset(%{timestamp: DateTime.utc_now(), log_data: %{line: "\"mp_fraglimit\" = \"0\"", server: "test", type: "cvar", cvar: %{name: "mp_fraglimit", value: "0"}}}) |> Repo.insert!()
%ServerMapping{} |> ServerMapping.changeset(%{server_id: 12345, server_name: "test"}) |> Repo.insert!()

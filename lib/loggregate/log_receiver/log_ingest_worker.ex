defmodule Loggregate.LogReceiver.LogIngestWorker do
  alias Loggregate.{Repo, LogEntry}
  alias Loggregate.LogReceiver.LogParser

  def log_msg_passwd(data) do
    [password, message] = :binary.split(data, "L")
    {server_id, _} = Integer.parse(password)
    {timestamp, log_data} = LogParser.parse(message)
    %LogEntry{}
    |> LogEntry.changeset(%{timestamp: timestamp, log_data: Map.put_new(log_data, :server, server_id)})
    |> Repo.insert()
  end
end

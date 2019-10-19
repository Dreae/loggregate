defmodule Loggregate.LogReceiver.LogIngestWorker do
  alias Loggregate.{Repo, LogEntry}
  alias Loggregate.LogReceiver.LogParser

  def log_msg_passwd(data, {address, port}) do
    [password, message] = :binary.split(data, "L")
    {server_id, _} = Integer.parse(password)
    {timestamp, log_data} = LogParser.parse(message)
    ip_address = to_string(:inet_parse.ntoa(address))

    log_data = log_data
    |> Map.put_new(:server, server_id)
    |> Map.put_new(:address, "#{ip_address}:#{port}")

    %LogEntry{}
    |> LogEntry.changeset(%{timestamp: timestamp, log_data: log_data})
    |> Repo.insert()
  end
end

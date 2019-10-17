defmodule Loggregate.LogReceiver.LogIngestWorker do
  alias Loggregate.ServerMapping

  def log_msg_passwd(data) do
    [server_id, message] = :binary.split(data, "L")
    # TODO: Load server name and insert entry
    IO.puts(String.trim(message))
  end
end

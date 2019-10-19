defmodule Loggregate.LogReceiver.UdpListener do
  use GenServer

  def start_link(port \\ 26015) do
    GenServer.start_link(__MODULE__, port)
  end

  def init(port) do
    :gen_udp.open(port, [:binary, active: true])
  end

  def handle_info({:udp, _socket, address, port, <<0xff, 0xff, 0xff, 0xff, 0x53, data::binary>>}, socket) do
    Task.start(Loggregate.LogReceiver.LogIngestWorker, :log_msg_passwd, [data, {address, port}])
    {:noreply, socket}
  end

  def handle_info({:udp, _socket, _address, _port, _data}, socket) do
    {:noreply, socket}
  end
end

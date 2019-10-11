defmodule Loggregate.LogEntry do
  use Ecto.Schema
  import Ecto.Changeset

  schema "log_entries" do
    field :message, :string
    field :timestamp, :naive_datetime

    timestamps()
  end

  @doc false
  def changeset(log_entry, attrs) do
    log_entry
    |> cast(attrs, [:timestamp, :message])
    |> validate_required([:timestamp, :message])
  end
end

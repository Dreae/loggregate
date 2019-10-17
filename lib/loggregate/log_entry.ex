defmodule Loggregate.LogEntry do
  use Ecto.Schema
  import Ecto.Changeset

  schema "log_entries" do
    field :log_data, :map
    field :timestamp, :naive_datetime

    timestamps()
  end

  @doc false
  def changeset(log_entry, attrs) do
    log_entry
    |> cast(attrs, [:timestamp, :log_data])
    |> validate_required([:timestamp, :log_data])
  end
end

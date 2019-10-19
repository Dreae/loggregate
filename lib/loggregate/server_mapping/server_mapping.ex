defmodule Loggregate.ServerMapping.ServerMapping do
  use Ecto.Schema
  import Ecto.Changeset

  schema "server_mapping" do
    field :server_id, :integer
    field :server_name, :string

    timestamps()
  end

  @doc false
  def changeset(server_mapping, attrs) do
    server_mapping
    |> cast(attrs, [:server_id, :server_name])
    |> validate_required([:server_id, :server_name])
  end
end

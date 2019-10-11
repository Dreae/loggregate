defmodule Loggregate.Repo.Migrations.CreateLogEntries do
  use Ecto.Migration

  def change do
    create table(:log_entries) do
      add :timestamp, :naive_datetime
      add :message, :string

      timestamps()
    end

  end
end

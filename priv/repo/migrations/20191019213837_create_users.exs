defmodule Loggregate.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :username, :string, primary_key: true
      add :password, :string
      add :admin, :boolean

      timestamps()
    end

  end
end

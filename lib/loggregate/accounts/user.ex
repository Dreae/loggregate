defmodule Loggregate.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    field :username, :string
    field :password, :string
    field :admin, :boolean

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:username, :password, :admin])
    |> validate_required([:username, :password, :admin])
    |> unique_constraint(:username)
    |> hash_password()
  end

  def hash_password(user) do
    case user do
      %Ecto.Changeset{valid?: true, changes: %{password: pass}} ->
        put_change(user, :password, Argon2.hash_pwd_salt(pass))
      _ ->
        user
    end
  end
end

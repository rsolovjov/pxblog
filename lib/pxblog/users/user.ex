defmodule Pxblog.Users.User do
  use Ecto.Schema
  import Ecto.Changeset
  import Comeonin.Bcrypt, only: [hashpwsalt: 1]
  alias Pxblog.Posts.Post

  schema "users" do
    field :email, :string
    field :password_digest, :string
    field :username, :string

    timestamps()

    has_many :posts, Post
    belongs_to :role, Pxblog.Roles.Role

    # Virtual Fields
    field :password, :string, virtual: true
    field :password_confirmation, :string, virtual: true
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:username, :email, :password, :password_confirmation, :role_id])
    |> validate_required([:username, :email, :password, :password_confirmation, :role_id])
    |> hash_password
  end

  defp hash_password(changeset) do
    if password = get_change(changeset, :password) do
      changeset
      |> put_change(:password_digest, hashpwsalt(password))
    else
      changeset
    end
  end
end

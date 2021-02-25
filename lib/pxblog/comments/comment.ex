defmodule Pxblog.Comments.Comment do
  use Ecto.Schema
  import Ecto.Changeset

  schema "comments" do
    field :approved, :boolean, default: false
    field :author, :string
    field :body, :string
    field :post_id, :id

    timestamps()
  end

  @doc false
  def changeset(comment, attrs) do
    comment
    |> cast(attrs, [:author, :body, :approved])
    |> validate_required([:author, :body, :approved])
  end
end

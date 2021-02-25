defmodule PxblogWeb.PostView do
  use PxblogWeb, :view

  def markdown(body) do
    body
    |> Earmark.to_html
    |> raw
  end
end

defmodule PxblogWeb.PageController do
  use PxblogWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end

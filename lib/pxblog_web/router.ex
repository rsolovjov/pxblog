defmodule PxblogWeb.Router do
  use PxblogWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", PxblogWeb do
    pipe_through :browser

    get "/", PageController, :index
    resources "/users", UserController do
      resources "/posts", PostController
    end
    resources "/posts", PostController, only: [] do
      resources "/comments", CommentController, only: [:create, :delete, :update]
    end
    resources "/sessions", SessionController, only: [:new, :create, :delete]
  end

  # Other scopes may use custom stacks.
  # scope "/api", PxblogWeb do
  #   pipe_through :api
  # end
end

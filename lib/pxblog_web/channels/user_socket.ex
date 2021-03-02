defmodule PxblogWeb.UserSocket do
  use Phoenix.Socket
  import Logger

  ## Channels
  # channel "room:*", PxblogWeb.RoomChannel
  channel "comments:*", PxblogWeb.CommentChannel

  # Socket params are passed from the client and can
  # be used to verify and authenticate a user. After
  # verification, you can put default assigns into
  # the socket that will be set for all channels, ie
  #
  #     {:ok, assign(socket, :user_id, verified_user_id)}
  #
  # To deny connection, return `:error`.
  #
  # See `Phoenix.Token` documentation for examples in
  # performing token verification on connect.
  def connect(%{"token" => token}, socket) do
    Logger.debug("connect. token: #{token}")
    case Phoenix.Token.verify(socket, "user", token, max_age: 1209600) do
      {:ok, user_id} ->
        {:ok, assign(socket, :user, user_id)}
      {:error, reason} ->
        {:ok, socket}
    end
  end

  #def connect(_params, socket, _connect_info) do
  #  {:ok, socket}
  #end

  # Socket id's are topics that allow you to identify all sockets for a given user:
  #
  #     def id(socket), do: "user_socket:#{socket.assigns.user_id}"
  #
  # Would allow you to broadcast a "disconnect" event and terminate
  # all active sockets and channels for a given user:
  #
  #     PxblogWeb.Endpoint.broadcast("user_socket:#{user.id}", "disconnect", %{})
  #
  # Returning `nil` makes this socket anonymous.
  def id(_socket), do: nil
end

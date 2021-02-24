defmodule Pxblog.UsersTest do
  use Pxblog.DataCase

  alias Pxblog.Users

  describe "users" do
    alias Pxblog.Users.User

    @valid_attrs %{email: "some email", password: "test1234", password_confirmation: "test1234", username: "some username"}
    @update_attrs %{email: "some updated email", password_digest: "some updated password_digest", username: "some updated username"}
    @invalid_attrs %{email: nil, password_digest: nil, username: nil}

    def user_fixture(attrs \\ %{}) do
      {:ok, user} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Users.create_user()

      user
    end

    test "list_users/0 returns all users" do
      user = user_fixture()
      [list_user] = Users.list_users()
      assert list_user.email == user.email
    end

    test "get_user!/1 returns the user with given id" do
      user = user_fixture()
      #assert Users.get_user!(user.id) == user
      get_user = Users.get_user!(user.id)
      assert get_user.email == user.email
    end

    test "create_user/1 with valid data creates a user" do
      assert {:ok, %User{} = user} = Users.create_user(@valid_attrs)
      assert user.email == "some email"
      #assert user.password_digest == "some password_digest"
      assert user.username == "some username"
    end

    test "password_digest value gets set to a hash" do
        changeset = User.changeset(%User{}, @valid_attrs)
        assert Comeonin.Bcrypt.checkpw(@valid_attrs.password, Ecto.Changeset.get_change(changeset, :password_digest))
    end

    test "password_digest value does not get set if password is nil" do
      changeset = User.changeset(%User{}, %{email: "[email protected]", password: nil, password_confirmation: nil, username: "test"})
      refute Ecto.Changeset.get_change(changeset, :password_digest)
    end

    test "create_user/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Users.create_user(@invalid_attrs)
    end

    test "update_user/2 with valid data updates the user" do
      user = user_fixture()
      assert {:ok, %User{} = user} = Users.update_user(user, @update_attrs)
      assert user.email == "some updated email"
      #assert user.password_digest == "some updated password_digest"
      assert user.username == "some updated username"
    end

    test "update_user/2 with invalid data returns error changeset" do
      user = user_fixture()
      assert {:error, %Ecto.Changeset{}} = Users.update_user(user, @invalid_attrs)
      #assert user == Users.get_user!(user.id)
      get_user = Users.get_user!(user.id)
      assert get_user.email == user.email
    end

    test "delete_user/1 deletes the user" do
      user = user_fixture()
      assert {:ok, %User{}} = Users.delete_user(user)
      assert_raise Ecto.NoResultsError, fn -> Users.get_user!(user.id) end
    end

    test "change_user/1 returns a user changeset" do
      user = user_fixture()
      assert %Ecto.Changeset{} = Users.change_user(user)
    end
  end
end

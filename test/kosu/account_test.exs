defmodule Kosu.AccountTest do
  use Kosu.DataCase, async: true

  import Kosu.Factory

  alias Kosu.Account

  describe "users" do
    alias Kosu.Account.User

    @invalid_attrs %{email: nil, name: nil, password: nil}

    test "list_users/0 returns all users" do
      user = insert(:user)
      assert Account.list_users() == [user]
    end

    test "get_user!/1 returns the user with given id" do
      user = insert(:user)
      assert Account.get_user!(user.id) == user
    end

    test "create_user/1 with valid data creates a user" do
      valid_attrs = params_for(:user)

      assert {:ok, %User{} = user} = Account.create_user(valid_attrs)
      assert user.email == valid_attrs.email
      assert user.name == valid_attrs.name
    end

    test "create_user/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Account.create_user(@invalid_attrs)
    end

    test "update_user/2 with valid data updates the user" do
      user = insert(:user)
      update_attrs = params_for(:user, %{password: "somepassword"})

      assert {:ok, %User{} = user} = Account.update_user(user, update_attrs)
      assert user.email == update_attrs.email
      assert user.name == update_attrs.name
      assert user.password =~ "$2b$"
    end

    test "update_user/2 with invalid data returns error changeset" do
      user = insert(:user)
      assert {:error, %Ecto.Changeset{}} = Account.update_user(user, @invalid_attrs)
      assert user == Account.get_user!(user.id)
    end

    test "delete_user/1 deletes the user" do
      user = insert(:user)
      assert {:ok, %User{}} = Account.delete_user(user)
      assert_raise Ecto.NoResultsError, fn -> Account.get_user!(user.id) end
    end
  end
end

defmodule KosuWeb.UserControllerTest do
  use KosuWeb.ConnCase

  import Kosu.Factory

  alias Kosu.Account.User

  @create_attrs %{
    email: "some email",
    name: "some name",
    password: "some password"
  }
  @update_attrs %{
    email: "some updated email",
    name: "some updated name",
    password: "some updated password"
  }
  @invalid_attrs %{email: nil, name: nil, password: nil}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all users", %{conn: conn} do
      user = insert(:user)

      conn = get(conn, Routes.user_path(conn, :index))

      assert [subject] = json_response(conn, 200)["data"]
      assert subject["id"] == user.id
    end
  end

  describe "show" do
    test "returns error when not exist", %{conn: conn} do
      conn = get(conn, Routes.user_path(conn, :show, 0))

      assert "Not Found" = json_response(conn, 404)["errors"]["detail"]
    end
  end

  describe "create" do
    test "renders user when data is valid", %{conn: conn} do
      params = @create_attrs

      conn = post(conn, Routes.user_path(conn, :create), user: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.user_path(conn, :show, id))

      assert subject = json_response(conn, 200)["data"]
      assert subject["id"] == id
      assert subject["name"] == params.name
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.user_path(conn, :create), user: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update" do
    setup [:create_user]

    test "renders user when data is valid", %{conn: conn, user: %User{id: id} = user} do
      conn = put(conn, Routes.user_path(conn, :update, user), user: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.user_path(conn, :show, id))

      assert %{
               "id" => ^id,
               "email" => "some updated email",
               "name" => "some updated name",
               "password" => "some updated password"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, user: user} do
      conn = put(conn, Routes.user_path(conn, :update, user), user: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete" do
    setup [:create_user]

    test "deletes chosen user", %{conn: conn, user: user} do
      conn = delete(conn, Routes.user_path(conn, :delete, user))
      assert response(conn, 204)
    end
  end

  defp create_user(_) do
    user = insert(:user)
    %{user: user}
  end
end

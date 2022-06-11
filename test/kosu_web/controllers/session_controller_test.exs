defmodule KosuWeb.SessionControllerTest do
  use KosuWeb.ConnCase, async: true

  import Kosu.Factory

  setup %{conn: conn} do
    user = insert(:user)

    {:ok, conn: put_req_header(conn, "accept", "application/json"), user: user}
  end

  describe "create" do
    test "returns token when valid user's data", %{conn: conn, user: user} do
      params = %{email: user.email, password: "somepassword"}

      conn = post(conn, Routes.session_path(conn, :create), params)

      assert subject = json_response(conn, 201)["data"]
      assert subject["token"] =~ "SFMyNTY."
    end

    test "returns token when invalid user's email", %{conn: conn} do
      params = %{email: "email-errado@mail.com", password: "somepassword"}

      conn = post(conn, Routes.session_path(conn, :create), params)

      assert json_response(conn, 401)
    end

    test "returns token when invalid user's password", %{conn: conn, user: user} do
      params = %{email: user.email, password: "password"}

      conn = post(conn, Routes.session_path(conn, :create), params)

      assert json_response(conn, 401)
    end
  end
end

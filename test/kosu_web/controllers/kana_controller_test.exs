defmodule KosuWeb.KanaControllerTest do
  use KosuWeb.ConnCase, async: true

  import Kosu.Factory

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "show" do
    test "returns ok when data is valid", %{conn: conn} do
      kana = insert(:kana)

      conn = get(conn, "/api/kanas/#{kana.id}")

      assert subject = json_response(conn, 200)["data"]
      assert subject["value"] == kana.value
      assert subject["romaji"] == kana.romaji
      assert subject["type"] == Atom.to_string(kana.type)
    end

    test "returns erro when kana doesn't exist", %{conn: conn} do
      conn = get(conn, "/api/kanas/0")

      assert json_response(conn, 404)["errors"]["detail"] == "Not Found"
    end
  end
end

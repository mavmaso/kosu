defmodule KosuWeb.KanaController do
  use KosuWeb, :controller

  alias Kosu.Content

  action_fallback KosuWeb.FallbackController

  def show(conn, %{"id" => id}) do
    with {:ok, kana} <- Content.get_kana(id) do
      render(conn, "show.json", %{kana: kana})
    end
  end

  def index(conn, _), do: render(conn, "index.json", %{kanas: Content.list_kanas})
end

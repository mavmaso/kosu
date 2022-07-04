defmodule KosuWeb.KanaView do
  use KosuWeb, :view

  def render("show.json", %{kana: kana}) do
    %{data: render_one(kana, __MODULE__, "kana.json")}
  end

  def render("kana.json", %{kana: kana}) do
    %{
      id: kana.id,
      value: kana.value,
      romaji: kana.romaji,
      type: kana.type
    }
  end
end

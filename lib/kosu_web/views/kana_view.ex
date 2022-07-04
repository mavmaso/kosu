defmodule KosuWeb.KanaView do
  use KosuWeb, :view

  def render("index.json", %{kanas: kanas}) do
    %{data: render_many(kanas, __MODULE__, "kana.json")}
  end

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

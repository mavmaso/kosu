defmodule Kosu.Content.Kana do
  use Ecto.Schema

  schema "kanas" do
    field :romaji, :string
    field :value, :string
    field :type, Ecto.Enum, values: [:hiragana, :katakana]

    timestamps()
  end
end

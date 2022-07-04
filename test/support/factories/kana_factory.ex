defmodule Kosu.KanaFactory do
  defmacro __using__(_opts) do
    quote do
      def kana_factory do
        %Kosu.Content.Kana{
          value: "あ",
          romaji: "A",
          type: :hiragana
        }
      end
    end
  end
end

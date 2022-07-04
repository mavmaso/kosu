# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Kosu.Repo.insert!(%Kosu.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.
alias Kosu.Content.Kana

Kosu.Repo.insert!(%Kana{
  value: "あ",
  romaji: "A",
  type: :hiragana
})

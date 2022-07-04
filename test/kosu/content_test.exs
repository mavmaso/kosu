defmodule Kosu.ContentTest do
  use Kosu.DataCase, async: true

  import Kosu.Factory

  alias Kosu.Content

  describe "kanas" do
    test "list_kanas/0 returns all kanas" do
      kana = insert(:kana)
      assert [subject] = Content.list_kanas()
      assert subject.id == kana.id
    end

    test "get_kana!/1 returns the kana with given id" do
      kana = insert(:kana)

      assert subject = Content.get_kana!(kana.id)
      assert subject.value == kana.value
    end

    test "get_kana/1 returns the kana with given id" do
      kana = insert(:kana)

      assert {:ok, subject} = Content.get_kana(kana.id)
      assert subject.romaji == kana.romaji
    end
  end
end

defmodule Kosu.Factory do
  use ExMachina.Ecto, repo: Kosu.Repo

  use Kosu.UserFactory
end

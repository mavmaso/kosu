defmodule Kosu.Repo.Migrations.CreateKanas do
  use Ecto.Migration

  def change do
    create table(:kanas) do
      add :value, :string
      add :romaji, :string
      add :type, :string

      timestamps()
    end
  end
end

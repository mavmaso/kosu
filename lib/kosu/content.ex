defmodule Kosu.Content do
  @moduledoc """
  The Content context.
  """

  import Ecto.Query, warn: false
  alias Kosu.Repo

  alias Kosu.Content.Kana

  @doc """
  Returns the list of kanas.

  ## Examples

      iex> list_kanas()
      [%Kana{}, ...]

  """
  def list_kanas do
    Repo.all(Kana)
  end

  @doc """
  Gets a single kana.

  Raises `Ecto.NoResultsError` if the Kana does not exist.

  ## Examples

      iex> get_kana!(123)
      %Kana{}

      iex> get_kana!(456)
      ** (Ecto.NoResultsError)

  """
  def get_kana!(id), do: Repo.get!(Kana, id)

  @doc """
  Returns a %Kana{} or :not_found in a tuple.
  """
  def get_kana(id) do
    case Repo.get(Kana, id) do
      nil -> {:error, :not_found}
      %Kana{} = kana -> {:ok, kana}
    end
  end
end

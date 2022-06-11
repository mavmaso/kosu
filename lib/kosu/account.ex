defmodule Kosu.Account do
  @moduledoc """
  The Account context.
  """

  import Ecto.Query, warn: false
  alias Kosu.Repo

  alias Kosu.Account.User

  @doc """
  Returns the list of users.

  ## Examples

      iex> list_users()
      [%User{}, ...]

  """
  def list_users do
    Repo.all(User)
  end

  @doc """
  Gets a single user.

  Raises `Ecto.NoResultsError` if the User does not exist.

  ## Examples

      iex> get_user!(123)
      %User{}

      iex> get_user!(456)
      ** (Ecto.NoResultsError)

  """
  def get_user!(id), do: Repo.get!(User, id)

  @doc """
  Returns an user if exists.
  """
  @spec get_user(String.t() | integer()) :: {:ok, User.t()} | {:error, :not_found}
  def get_user(id) do
    case Repo.get(User, id) do
      nil -> {:error, :not_found}
      %User{} = user -> {:ok, user}
    end
  end

  defp get_user_by_email(email) do
    case Repo.get_by(User, email: email) do
      nil ->
        Bcrypt.no_user_verify()
        {:error, :invalid_login}

      user ->
        {:ok, user}
    end
  end

  @doc """
  WIP
  """
  @spec authenticate_user(String.t(), String.t()) :: {:ok, User.t()} | {:error, :invalid_login}
  def authenticate_user(email, password) do
    with {:ok, user} <- get_user_by_email(email), do: verify_password(password, user)
  end

  defp verify_password(password, %User{} = user) do
    if Bcrypt.verify_pass(password, user.password) do
      {:ok, user}
    else
      {:error, :invalid_login}
    end
  end

  @doc """
  Creates a user.

  ## Examples

      iex> create_user(%{field: value})
      {:ok, %User{}}

      iex> create_user(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_user(attrs) do
    %User{}
    |> User.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a user.

  ## Examples

      iex> update_user(user, %{field: new_value})
      {:ok, %User{}}

      iex> update_user(user, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_user(%User{} = user, attrs) do
    user
    |> User.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a user.

  ## Examples

      iex> delete_user(user)
      {:ok, %User{}}

      iex> delete_user(user)
      {:error, %Ecto.Changeset{}}

  """
  def delete_user(%User{} = user) do
    Repo.delete(user)
  end
end

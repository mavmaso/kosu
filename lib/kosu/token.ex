defmodule Kosu.Token do
  @signing_salt "curso_api"
  # token for 2 week
  @token_age_secs 14 * 86_400

  @doc """
  Create token for given data
  """
  @spec sign_in(map()) :: {:ok, bitstring()}
  def sign_in(data), do: {:ok, Phoenix.Token.sign(KosuWeb.Endpoint, @signing_salt, data)}

  @doc """
  Verify given token by:
  - Verify token signature
  - Verify expiration time
  """
  @spec verify(String.t()) :: {:ok, any()} | {:error, :unauthenticated}
  def verify(token) do
    case Phoenix.Token.verify(KosuWeb.Endpoint, @signing_salt, token, max_age: @token_age_secs) do
      {:ok, data} -> {:ok, data}
      _error -> {:error, :unauthenticated}
    end
  end
end

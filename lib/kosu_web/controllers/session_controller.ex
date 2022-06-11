defmodule KosuWeb.SessionController do
  use KosuWeb, :controller

  alias Kosu.Account
  alias Kosu.Token

  action_fallback KosuWeb.FallbackController

  def create(conn, %{"email" => email, "password" => password}) do
    with {:ok, user} <- Account.authenticate_user(email, password),
         {:ok, token} <- Token.sign_in(%{user_id: user.id}) do
      conn
      |> put_status(:created)
      |> json(%{data: %{token: token}})
    end
  end
end

defmodule Kosu.Plug.Authenticate do
  import Plug.Conn
  require Logger

  def init(opts), do: opts

  def call(conn, _opts) do
    with ["Bearer " <> token] <- get_req_header(conn, "authorization"),
         {:ok, data} <- Kosu.Token.verify(token) do
      conn
      |> assign(:current_user, Kosu.Account.get_user(data.user_id))
    else
      _error ->
        conn
        |> put_status(:unauthorized)
        |> Phoenix.Controller.put_view(KosuWeb.ErrorView)
        |> Phoenix.Controller.render(:"401")
        |> halt()
    end
  end
end

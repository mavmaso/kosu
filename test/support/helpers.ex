defmodule Kosu.Helpers do
  import Plug.Conn

  alias Kosu.Account.User

  def login(conn, %User{} = user) do
    {:ok, token} = Kosu.Token.sign_in(%{user_id: user.id})
    put_req_header(conn, "authorization", "Bearer #{token}")
  end
end

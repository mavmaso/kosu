defmodule KosuWeb.MacroHelpers do
  @moduledoc """
  Macros to help with testing authentication, ensuring routes protection
  """

  @doc """
  Ensure the route is protected by authentication
  """
  defmacro ensure_authentication(verb, path) do
    quote do
      test "returns unauthorized when not authenticated on #{unquote(verb)}:#{unquote(path)}" do
        conn = Phoenix.ConnTest.build_conn()

        response = dispatch(conn, @endpoint, unquote(verb), unquote(path))

        assert response(response, :unauthorized)
      end
    end
  end
end

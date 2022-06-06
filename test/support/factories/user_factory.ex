defmodule Kosu.UserFactory do
  defmacro __using__(_opts) do
    quote do
      def user_factory do
        %Kosu.Account.User{
          name: "oi",
          email: sequence(:email, &"gandalf#{&1}@mail.com"),
          password: "123"
        }
      end
    end
  end
end

defmodule Kosu.UserFactory do
  defmacro __using__(_opts) do
    quote do
      def user_factory do
        %Kosu.Account.User{
          name: "oi",
          email: sequence(:email, &"gandalf#{&1}@mail.com"),
          password: "$2b$12$iWNYYuxNcQhaUuJ82jLKu..jbrQQl8..it6K5AvdVovOwDmLX2OVu"
        }
      end
    end
  end
end

defmodule LoginService.Login do
  alias LoginService.User

  def login(params, repo) do
    IO.puts "**********************"
    IO.puts params["email"]
    IO.puts "**********************"

    user = repo.get_by(User, email: params["email"])
    case authenticate(user, params["password"]) do
          true -> {:ok, user}
          _ -> {:error, "User Failed to autheticate"}
    end
  end

  defp authenticate(user, password) do
    case user do
      nil -> false
      _ -> Comeonin.Bcrypt.checkpw(password, user.crypted_password)
    end
  end
end

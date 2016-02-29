defmodule LoginService.Login do
  require Logger
  alias LoginService.User

  def login(params, repo) do
    user = repo.get_by(User, email: params["email"])
    case authenticate(user, params["password"]) do
          true -> {:ok, user}
          _ -> Logger.error "failed to authenticate user"
              {:error, "User Failed to autheticate"}
    end
  end

  defp authenticate(user, password) do
    case user do
      nil -> false
      _ -> Comeonin.Bcrypt.checkpw(password, user.crypted_password)
    end
  end
end

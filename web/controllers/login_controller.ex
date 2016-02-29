defmodule LoginService.LoginController do
  require Logger
    use LoginService.Web, :controller

def authenticate(conn, %{"user" => user_params}) do
  response = LoginService.Login.login(user_params,LoginService.Repo)
  case response do
    {:ok, user} ->
                      {:ok, jwt, full_claims} = Guardian.encode_and_sign(user, :token)
                      conn
                      |> put_status(:ok)
                      |> put_resp_content_type("application/json")
                      |> json(%{token: jwt})
    {:error} -> Logger.error "Failed to authenticate user with given user name and password"
                      conn
                      |> put_status(:unprocessable_entity)
  end
end

end

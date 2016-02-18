defmodule LoginService.LoginController do
    use LoginService.Web, :controller

def authenticate(conn, user_params) do
  response = LoginService.Login.login(user_params,LoginService.Repo)
  case response do
    {:ok, user} ->
                      {:ok, jwt, full_claims} = Guardian.encode_and_sign(user, :token)

                      conn
                      |> put_status(:ok)
                      |> put_resp_content_type("application/json")
                      |> json(%{token: jwt})
    {:error} ->
                    conn
                      |> put_status(:unprocessable_entity)
  end
end

end

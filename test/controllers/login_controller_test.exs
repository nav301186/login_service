defmodule LoginService.LoginControllerTest do
  use LoginService.ConnCase
  alias LoginService.User

  @valid_attrs %{email: "nav@gmail.com", password: "12345" }
  @invalid_attrs %{}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  test 'User should get jwt in exchage for credentials', %{conn: conn} do
    password = "1234567"
    email = "example@gmail.com"
    crypted_password = Comeonin.Bcrypt.hashpwsalt(password)
    user = Repo.insert! %User{email: email, crypted_password: crypted_password}
    # {:ok, jwt, full_claims} = Guardian.encode_and_sign(user, :token)
    conn = post conn, login_path(conn, :authenticate,%{"user" => %{"email" =>  email,
     "password" => password}})
     assert json_response(conn, 200)
  end
end

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
    email = "nav546@gmail.com"
    crypted_password = Comeonin.Bcrypt.hashpwsalt(password)
    user = Repo.insert! %User{email: email, password: password, crypted_password: crypted_password}

    conn = post conn, login_path(conn, :authenticate, %{"email" =>  email, "password" => password})
     IO.puts json_response(conn, 200)["data"]
    # assert json_response(conn, 200)["data"] == %{token: Guardian.encode_and_sign(user, :token)}
  end
end

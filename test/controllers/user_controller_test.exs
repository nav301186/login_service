defmodule LoginService.UserControllerTest do
  use LoginService.ConnCase

  alias LoginService.User
  @valid_attrs %{age: 42, gender: "some content", name: "some content", email: "nav@gmail.com", crypted_password: "123456"}
  @invalid_attrs %{}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  test "shows chosen resource", %{conn: conn} do
    password = "password"
    user = Repo.insert! %User{email: "example1@gmail.com",password: password }

    {:ok, jwt, _} = Guardian.encode_and_sign(user, :token)

    conn = conn |> put_req_header("authorization",jwt)
    conn = get conn, user_path(conn, :show)
    assert json_response(conn, 200)
  end

  test "does not show resource and instead throw error when token is not valid", %{conn: conn} do
    password = "password"
    user = Repo.insert! %User{email: "example1@gmail.com",password: password }

    conn = conn |> put_req_header("authorization","InvalidToken")
                |> put_req_header("content-type", "application/json" )

    conn =   get conn, user_path(conn, :show)
    assert json_response(conn, 401)
  end

  test "updates and renders chosen resource when data is valid", %{conn: conn} do
    password = "password"
    user = Repo.insert! %User{email: "example1@gmail.com",password: password }
    # updated_user = %User{email: "example1@gmail.com",password: password, name: "Jon Doe" }

    {:ok, jwt, _} = Guardian.encode_and_sign(user, :token)

    conn = conn |> put_req_header("authorization",jwt)
    conn = put conn, user_path(conn, :update, %{"user" => %{name: "Jon Doe"}})
    assert json_response(conn, 200)["data"]["name"] == "Jon Doe"
    # assert Repo.get_by(User, @valid_attrs)
  end

  test "deletes chosen resource", %{conn: conn} do
    password = "password"
    user = Repo.insert! %User{email: "example1@gmail.com",password: password }

    {:ok, jwt, _} = Guardian.encode_and_sign(user, :token)

    conn = conn |> put_req_header("authorization",jwt)
    conn = delete conn, user_path(conn, :delete)
    assert response(conn, 204)
    refute Repo.get(User, user.id)
  end
end

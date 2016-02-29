defmodule LoginService.UserControllerTest do
  use LoginService.ConnCase
  alias LoginService.Repo
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
    IO.inspect json_response(conn, 200)["profile"]
    assert json_response(conn, 200)["profile"]["name"] == "Jon Doe"
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

  test "should return users based on filtered criteria", %{conn: conn} do
    user = Repo.insert! %User{email: "example1@gmail.com",password: "password", age: 21, gender: "M", name: "john" }
    user_params =Repo.insert! %User{email: "example2zcdf@gmail.com",password: "password" , age: 23, gender: "F", name: "leela" }
    # user2 = {email: "example3sfsfsd@gmail.com",password: "password", age: 20, gender: "female", name: "angila" }
    {:ok, jwt, _} = Guardian.encode_and_sign(user, :token)
    conn = conn |> put_req_header("authorization",jwt)
    conn = get conn, user_path(conn, :filter, [min_age: 21, max_age: 25])
    assert List.first(json_response(conn, 200)["profiles"])["profile"]["name"] == "leela"

  end

  test "should verrify the avatar link in the response" do
    user = Repo.insert! %User{email: "example1@gmail.com",password: "password", age: 21, gender: "M", name: "john" }
    user_to_search = Repo.insert! %User{email: "example2zcdf@gmail.com",password: "password" , age: 23, gender: "F", name: "leela" }
    # user2 = {email: "example3sfsfsd@gmail.com",password: "password", age: 20, gender: "female", name: "angila" }
    token = Comeonin.Bcrypt.hashpwsalt(to_string(user_to_search.id))
    {:ok, jwt, _} = Guardian.encode_and_sign(user, :token)
    conn = conn |> put_req_header("authorization",jwt)
    conn = get conn, user_path(conn, :filter, [min_age: 21, max_age: 25])
    IO.inspect json_response(conn, 200)
    assert List.first(json_response(conn, 200)["profiles"])["profile"]["avatar"] != nil
  end

  test "should always return result for opposite gender only" do
    user = Repo.insert! %User{email: "example1@gmail.com",password: "password", age: 21, gender: "M", name: "john" }
    Repo.insert! %User{email: "example11@gmail.com",password: "password", age: 24, gender: "M", name: "john galt" }
    Repo.insert! %User{email: "example12@gmail.com",password: "password", age: 24, gender: "M", name: "johny" }
    user_to_search = Repo.insert! %User{email: "example2zcdf@gmail.com",password: "password" , age: 23, gender: "F", name: "leela" }
    # user2 = {email: "example3sfsfsd@gmail.com",password: "password", age: 20, gender: "female", name: "angila" }

    token = Comeonin.Bcrypt.hashpwsalt(to_string(user_to_search.id))
    IO.inspect token

    {:ok, jwt, _} = Guardian.encode_and_sign(user, :token)
    conn = conn |> put_req_header("authorization",jwt)
    conn = get conn, user_path(conn, :filter, [min_age: 21, max_age: 25])
    IO.inspect json_response(conn, 200)
    assert Enum.count(json_response(conn, 200)["profiles"]) == 1
    assert List.first(json_response(conn, 200)["profiles"])["profile"]["name"] == "leela"
  end
end

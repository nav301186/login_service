defmodule LoginService.RegistrationControllerTest do
  use LoginService.ConnCase

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  test "should create user when provided right parameter", %{conn: conn} do
     conn = post conn, registration_path(conn, :register, %{"user" => %{email: "jondoe@gmail.com", name: "jon doe",
                                                              password: "password", age: 23, gender: "M"}})
    #  user =  Repo.get_by(User, email: "jondoe@gmail.com")
    #  assert user.email == "jondoe@gmail.com"
    assert conn.status == 204
   end
end

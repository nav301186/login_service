defmodule LoginService.DocumentsControllerTest do
use LoginService.ConnCase
alias LoginService.User

setup %{conn: conn} do
  {:ok, conn: put_req_header(conn, "accept", "application/json")}

end

test 'user should be able to upload his single image', %{conn: conn} do
  password = "password"
  user = Repo.insert! %User{email: "example1@gmail.com",password: password }

  {:ok, jwt, _} = Guardian.encode_and_sign(user, :token)

  conn = conn |> put_req_header("authorization",jwt)

 params = %{"avatar" => "/Users/navinnegi/sites/Elixir/login_service/test/testData/i-1.png"}
  conn = post conn, documents_path(conn,:upload, params)
  assert conn.status == 204
end

# test 'user should be able to retrieve the his single uploaded image', %{conn: conn} do
#   conn = get conn, documents_path(conn, :get)
#   assert conn.status == 200
# end

end

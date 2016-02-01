defmodule RegisterUserIntegrationTest do
  use LoginService.ConnCase
  alias LoginService.Router

  setup do
      
  {:ok, conn: conn}
    end


  test 'register a user' do
    conn = post conn(), registration_path(conn, :create)
    assert response(conn, 204)
    # assert response.status == 204
  end
end

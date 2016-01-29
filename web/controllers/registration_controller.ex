defmodule LoginService.RegistrationController do
  use LoginService.Web, :controller

  def create(conn, _params) do
    send_resp(conn, :no_content, "")
  end
end

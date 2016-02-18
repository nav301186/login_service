defmodule LoginService.RegistrationController do
  use LoginService.Web, :controller
  alias LoginService.User

  def register(conn, %{"user" => user_params}) do
    changeset = User.changeset(%User{}, user_params)

    case LoginService.Registration.create(changeset, LoginService.Repo) do
      {:ok, changeset} ->
                        IO.puts "*******Saved Successfully**********"
                        #  conn = conn |> put_resp_content_type("application/json")
                        send_resp(conn, :no_content, "")
      {:error, changeset} ->
                      send_resp(conn, 502, "")
    end
  end
end

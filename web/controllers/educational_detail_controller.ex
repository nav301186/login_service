defmodule LoginService.EducationalDetailController do
  import Ecto.Query, only: [from: 2]
  use LoginService.Web, :controller

  alias LoginService.User
  alias LoginService.UserAuthController
  alias LoginService.GuardianHelper
  alias LoginService.PersnalInformation
  alias LoginService.Repo
  alias LoginService.EducationalDetail
# If the plug cannot find a verified token for the connection,
# it calls the on_failure function.
 # This function should be arity 2 and receive a Plug.
 # Conn.t and it’s params. It’s up to this function
 # to handle what should happen when things go south.
 plug Guardian.Plug.EnsureAuthenticated , handler: LoginService.ErrorHandler

  # plug :scrub_params, "basic_info" when not action in [:delete, :show, :filter]

  def create(conn,  user_params) do
    IO.inspect user_params
      token = List.first(get_req_header(conn, "authorization"));

     case  Guardian.decode_and_verify(token) do

       { :ok, claims } ->
                         case Guardian.serializer.from_token(claims["sub"]) do
                           { :ok, resource } ->
                                                   info = Repo.get_by(EducationalDetail, user_id: resource.id)
                                                  IO.inspect info
                                                     changeset = EducationalDetail.changeset(info, user_params)
                                                    case  Repo.update(changeset) do
                                                            {:ok, info} ->  IO.puts "*******Saved Successfully**********"
                                                                            send_resp(conn, :no_content, "")
                                                            { :error, reason } -> conn |> put_status(:unprocessable_entity)
                                                    end

                           { :error, reason } -> conn |> put_status(:unprocessable_entity)
                         end

       { :error, reason } -> conn |> put_status(:unprocessable_entity)
     end
  end

  def show(conn,  user_params) do
    IO.inspect user_params
      token = List.first(get_req_header(conn, "authorization"));

     case  Guardian.decode_and_verify(token) do

       { :ok, claims } ->
                         case Guardian.serializer.from_token(claims["sub"]) do
                           { :ok, resource } ->
                                                   info = Repo.get_by(EducationalDetail, user_id: resource.id)
                                                  conn
                                                  |> put_status(200)
                                                  |> render("educational_detail.json", info: info)
                           { :error, reason } -> conn |> put_status(:unprocessable_entity)
                         end

       { :error, reason } -> conn |> put_status(:unprocessable_entity)
     end
  end
end

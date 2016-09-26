defmodule LoginService.PersnalInformationController do
  import Ecto.Query, only: [from: 2]
  use LoginService.Web, :controller


  alias LoginService.User
  alias LoginService.UserAuthController
  alias LoginService.GuardianHelper
  alias LoginService.Repo
  alias LoginService.PersnalInformation

  @defaults %{"max_age" => 100, "min_age" => 18}

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
                                                   info = Repo.get_by(PersnalInformation, user_id: resource.id)
                                                  IO.inspect info
                                                     changeset = PersnalInformation.changeset(info, user_params)
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
                                                   info = Repo.get_by(PersnalInformation, user_id: resource.id)
                                                  conn
                                                  |> put_status(200)
                                                  |> render("persnal_information.json", basic_info: info)
                           { :error, reason } -> conn |> put_status(:unprocessable_entity)
                         end

       { :error, reason } -> conn |> put_status(:unprocessable_entity)
     end
  end

  def filter(conn, filter_params) do
    token = List.first(get_req_header(conn, "authorization"));

    IO.inspect conn.query_params
    %{"max_age" => max, "min_age" => min} = merge_defaults(conn.query_params)

   case  UserAuthController.get_user(token) do
     {:ok, primary_user} ->  IO.puts "Trying to get profiles for  user: " <> primary_user.email <> "..."
                            IO.inspect primary_user
                            query = from(u in PersnalInformation, where: u.age > ^min and u.age < ^max)
                            infos = Repo.all query
                            IO.puts "record retrieved "
                            conn |> put_status(200) |> render("index.json", infos: infos)
      {:error, primary_user} ->  IO.puts "Failed to load User"
                            render("401.json", %{})
   end
  end

  defp merge_defaults(map) do
    IO.inspect map
    Map.merge(@defaults, map)
  end

end

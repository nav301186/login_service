defmodule LoginService.UserController do
  @defaults %{"max_age" => 100, "min_age" => 18}
  use LoginService.Web, :controller

  alias LoginService.User
  alias LoginService.UserAuthController
  alias LoginService.GuardianHelper
# If the plug cannot find a verified token for the connection,
# it calls the on_failure function.
 # This function should be arity 2 and receive a Plug.
 # Conn.t and it’s params. It’s up to this function
 # to handle what should happen when things go south.
 plug Guardian.Plug.EnsureAuthenticated , handler: LoginService.ErrorHandler

  plug :scrub_params, "user" when not action in [:delete, :show, :filter]

  def show(conn, _params) do
      token = List.first(get_req_header(conn, "authorization"));

       case  Guardian.decode_and_verify(token) do
         { :ok, claims } ->
                           case Guardian.serializer.from_token(claims["sub"]) do
                             { :ok, resource } ->
                                               user = Repo.get!(User, resource.id)
                                              conn
                                              |> put_status(200)
                                              |> render("show.json", user: user)
                             { :error, reason } -> conn |> put_status(502)
                           end

         { :error, reason } -> conn
                                    |> put_status(502)
                                    |> render("error.json")
       end
  end

  def update(conn, %{"user" => user_params}) do
    token = List.first(get_req_header(conn, "authorization"));

     case  Guardian.decode_and_verify(token) do

       { :ok, claims } ->
                         case Guardian.serializer.from_token(claims["sub"]) do
                           { :ok, resource } ->
                                                 user = Repo.get!(User, resource.id)

                                                 changeset = User.changeset(user, user_params)

                                                 case Repo.update(changeset) do
                                                   {:ok, user} ->
                                                     render(conn, "show.json", user: user)
                                                   {:error, changeset} ->
                                                     conn
                                                     |> put_status(502)
                                                     |> render(LoginService.ChangesetView, "error.json", changeset: changeset)
                                                 end

                           { :error, reason } -> conn |> put_status(:unprocessable_entity)
                         end

       { :error, reason } -> conn |> put_status(:unprocessable_entity)
     end
  end

  def delete(conn, _params) do

    token = List.first(get_req_header(conn, "authorization"));

     case  Guardian.decode_and_verify(token) do
       { :ok, claims } ->
                         case Guardian.serializer.from_token(claims["sub"]) do
                           { :ok, resource } ->
                                                 user = Repo.get!(User, resource.id)
                                                 Repo.delete!(user)
                                                 send_resp(conn, :no_content, "")

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
   {:ok, primary_user} ->  IO.puts "Trying to get profiles for  user: " <> primary_user.name <> "..."
                          IO.inspect primary_user
                          query = from(u in User, where: u.age > ^min and u.age < ^max and u.gender != ^primary_user.gender)
                          users = Repo.all query
                          conn |> put_status(200) |> render("index.json", users: users)
    {:error, primary_user} ->  render("401.json", %{})
 end
end

defp merge_defaults(map) do
  IO.inspect map
  Map.merge(@defaults, map)
end

# defp merge_defaults(map) do
#   Map.merge(@defaults, map, fn _key, default, val -> val || default end)
# end
end

defmodule LoginService.DocumentsController do
  require Logger
  use LoginService.Web, :controller

  alias LoginService.User
  alias LoginService.Avatar

def upload(conn, user_params) do
  case get_user(conn) do
     {:ok, scope}  ->
                     changeset = User.changeset(scope, user_params)
                       case Repo.update(changeset) do
                           {:ok, scope} ->  case Avatar.store({user_params["avatar"],scope}) do
                                                     {:ok, file} ->
                                                       send_resp(conn, :no_content, "")
                                                     {:error, error} ->
                                                      Logger.error(:error,"Failed to store image for user #{IO.inspect(scope)} ")
                                                       send_resp(conn, 500, "")
                                                   end
                         {:error, changeset} ->  send_resp(conn, :unprocessable_entity, changeset)
                     end
                   {:ok, reasons} -> conn |> json(%{error: "failed to save image", reasons: reasons})
              end
 end


def get(conn, user_params) do
  IO.inspect conn.query_params
  %{"isSelf" => isSelf, "id" => id} = conn.query_params
  is_avatar = isSelf == "true"
  case get_user(conn) do
               {:ok, user}  ->  if is_avatar do
                                 IO.puts "Loading self image ..."
                                 IO.inspect user
                                get_user_image(user, conn)
                                else
                                  requested_user = Repo.get(User, id)
                                  IO.puts "Loading requested image ..."
                                  IO.inspect requested_user
                                  get_user_image(requested_user, conn)
                                end
      {:ok, reasons} -> conn |> json(%{error: "failed to save image", reasons: reasons})
  end
 end

defp get_user_image(user, conn) do
  IO.inspect get_image_path(Avatar.url({user.avatar, user}))
  case File.open(get_image_path(Avatar.url({user.avatar, user})), [:read]) do
      {:ok, image_file} ->  image_data = IO.binread(image_file, :all)
                            conn
                            |> put_resp_content_type("image/jpeg")
                            |> send_resp(200, image_data)
      {:error, message} -> conn |>  json(%{error: "Failed to load image"})
     end
 end

defp get_user(conn) do
  token = List.first(get_req_header(conn, "authorization"));

   case  Guardian.decode_and_verify(token) do
     {:ok, claims } ->         IO.puts "token verified"
                                case Guardian.serializer.from_token(claims["sub"]) do
                               {:ok, resource } ->  IO.inspect resource
                                                    {:ok, Repo.get!(User, resource.id)}
                               { :error, reasons } -> { :error, reasons }
                       end
     { :error, reasons } -> {:error, reasons}
   end
end

defp get_image_path(uri) do
   [path, params] = String.split(uri, "?")
   path
end


end

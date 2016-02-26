defmodule LoginService.DocumentsController do
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
                                                   {:error, error} -> send_resp(conn, 500, "")
                                                 end
                       {:error, changeset} ->  send_resp(conn, :unprocessable_entity, changeset)
                   end
      {:ok, reasons} -> conn |> json(%{error: "failed to save image", reasons: reasons})
              end
  end


def get(conn, user_params) do
  case get_user(conn) do
     {:ok, user}  ->  path = get_image_path(Avatar.url({user.avatar, user}))
                      case File.open(path, [:read]) do
                      {:ok, image_file} ->  image_data = IO.binread(image_file, :all)
                                            conn
                                            |> put_resp_content_type("image/jpeg")
                                            |> send_resp(200, image_data)
                      {:error, message} -> conn |>  json(%{error: "Failed to load image"})
                      end
      {:ok, reasons} -> conn |> json(%{error: "failed to save image", reasons: reasons})
              end
  end



defp get_user(conn) do
  token = List.first(get_req_header(conn, "authorization"));
  IO.inspect token
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
   IO.inspect path
  path
end


end

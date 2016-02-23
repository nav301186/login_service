defmodule LoginService.DocumentsController do
  use LoginService.Web, :controller

  alias LoginService.User
  alias LoginService.Avatar

def upload(conn, user_params) do

  case get_user(conn) do
     {:ok, scope}  ->
                      IO.puts "========================"
                      IO.inspect scope
                      IO.inspect user_params
                      IO.puts "========================"
                     changeset = User.changeset(scope, user_params)

                     case Repo.update(changeset) do
                         {:ok, scope} ->  case Avatar.store({user_params["avatar"],scope}) do
                                                   {:ok, file} -> send_resp(conn, :no_content, "")
                                                   {:error, error} -> send_resp(conn, 500, "")
                                                 end
                       {:error, changeset} ->  send_resp(conn, :unprocessable_entity, changeset)
                   end
      {:ok, reasons} -> conn |> json(%{error: "failed to save image", reasons: reasons})
              end
        end


def get(conn, user_params) do
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

defp get_user(conn) do

  token = List.first(get_req_header(conn, "authorization"));

   case  Guardian.decode_and_verify(token) do
     {:ok, claims } -> case Guardian.serializer.from_token(claims["sub"]) do
                               {:ok, resource } -> {:ok, Repo.get!(User, resource.id)}
                               { :error, reason } -> { :error, reason }
                       end
     { :error, reasons } -> {:error, reasons}
   end
end

end

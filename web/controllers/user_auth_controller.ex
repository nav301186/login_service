defmodule LoginService.UserAuthController do
alias LoginService.Repo
alias LoginService.User

  def get_user(token) do
    # token = List.first(get_req_header(conn, "authorization"));
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
end

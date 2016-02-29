defmodule LoginService.Router do
  use LoginService.Web, :router

  pipeline :api do
    plug :accepts, ["json"]
    plug Guardian.Plug.VerifyHeader
    plug Guardian.Plug.LoadResource

  end

  scope "/api", LoginService do
    pipe_through :api

    post "/register", RegistrationController, :register
    post "/authenticate", LoginController, :authenticate
    get "/user", UserController, :show
    put "/user", UserController, :update
    get "/profiles", UserController, :filter
    delete "/user", UserController, :delete
    post "/documents", DocumentsController, :upload
    get "/documents", DocumentsController, :get
  end
end

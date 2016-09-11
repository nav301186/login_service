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
    get "/users/me", UserController, :show
    put "/users/me", UserController, :update
    get "/profiles", UserController, :filter
    delete "/users/me", UserController, :delete
    get "/users/me/basicInfo", BasicInfoController, :show
    # put "/users/me/basicInfo", BasicInfoController, :update
    # delete "/users/me/basicInfo", BasicInfoController, :delete
    put "/users/me/basicInfo", BasicInfoController, :create
    post "/documents", DocumentsController, :upload
    get "/documents", DocumentsController, :get

  end
end

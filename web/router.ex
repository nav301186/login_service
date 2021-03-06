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
    get "/profiles", PersnalInformationController, :filter
    delete "/users/me", UserController, :delete
    get "basicinfos/me", PersnalInformationController, :show
    put "basicInfos/me", PersnalInformationController, :create
    get "educationalDetails/me", EducationalDetailController, :show
    put "educationalDetails/me", EducationalDetailController, :create
    post "/documents", DocumentsController, :upload
    get "/documents", DocumentsController, :get

  end
end

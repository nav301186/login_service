defmodule LoginService.UserView do
  use LoginService.Web, :view
  alias LoginService.Avatar
  alias Comeonin.Bcrypt

  def render("index.json", %{users: users}) do
    %{profiles: render_many(users, LoginService.UserView, "show.json")}
  end

  def render("show.json", %{user: user}) do
    %{user: render_one(user, LoginService.UserView, "user.json")}
  end

  def render("token.json", %{token: token}) do
     %{token: token}
  end

  def render("user.json", %{user: user}) do
    %{
      id: user.id,
      email: user.email,
    }
  end

  def generate_url(user) do
    "/api/documents?isSelf=false&id=" <> to_string(user.id)
  end
end

defmodule LoginService.UserView do
  use LoginService.Web, :view

  def render("index.json", %{users: users}) do
    %{data: render_many(users, LoginService.UserView, "user.json")}
  end

  def render("show.json", %{user: user}) do
    %{data: render_one(user, LoginService.UserView, "user.json")}
  end

  def render("token.json", %{token: token}) do
    %{token: token}
  end

  def render("user.json", %{user: user}) do
    %{id: user.id,
      name: user.name,
      age: user.age,
      gender: user.gender,
      email: user.email}
  end
end

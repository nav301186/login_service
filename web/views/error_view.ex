defmodule LoginService.ErrorView do
  use LoginService.Web, :view

  def render("404.json", _assigns) do
    %{errors: %{detail: "Page not found"}}
  end

  def render("500.json", _assigns) do
    %{errors: %{detail: "Server internal error"}}
  end
  def render("401.json", _assigns) do
    %{errors: %{detail: "user authentication failed, ensure that correct authentication token is being sent in the auth header"}}
  end

  # In case no render clause matches or no
  # template is found, let's render it as 500
  def template_not_found(_template, assigns) do
    render "500.json", assigns
  end
end

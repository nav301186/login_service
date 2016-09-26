defmodule LoginService.BasicInfoView do
  use LoginService.Web, :view

  def render("index.json", %{infos: infos}) do
    render_many(infos, LoginService.BasicInfoView, "show.json")
  end

  def render("show.json", info) do
    render_one(info, LoginService.BasicInfoView, "basic_info.json")
  end

    def render("basic_info.json",  %{basic_info: info}) do
      %{
        id: info.id,
        name: info.name,
        age: info.age,
        contact_number: info.contact_number,
        dob: info.dob,
        current_city: info.city,
        hometown: info.hometown
      }
    end
end

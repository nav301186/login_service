defmodule LoginService.PersnalInformationView do
  use LoginService.Web, :view

  def render("index.json", %{infos: infos}) do
    render_many(infos, LoginService.PersnalInformationView, "show.json")
  end

  def render("show.json", %{persnal_information: info}) do
    render_one(info, LoginService.PersnalInformationView, "persnal_information.json")
  end

    def render("persnal_information.json",   %{persnal_information: info}) do
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

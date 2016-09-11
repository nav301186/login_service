defmodule LoginService.BasicInfoView do
  use LoginService.Web, :view

  def render("show.json", %{info: info}) do
    %{info: render_one(info, LoginService.BasicInfoView, "basic-info.json")}
  end

    def render("basic-info.json", %{info: info}) do
      %{id: info.id,
        name: info.name,
        age: info.age,
        # gender: info.gender,
        contact_number: info.contact_number,
        dob: info.dob,
        current_city: info.city,
        hometown: info.hometown

      }
    end
end

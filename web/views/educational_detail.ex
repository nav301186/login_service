defmodule LoginService.EducationalDetailView do
  use LoginService.Web, :view

  def render("show.json", %{info: info}) do
    %{info: render(info, LoginService.EducationalDetailView, "educational_detail.json")}
  end

    def render("educational_detail.json", %{info: info}) do
      %{
        id: info.id,
        graduation: info.graduation,
        intermediate: info.intermediate,
        senior_secondary: info.senior_secondary,
      }
    end
end

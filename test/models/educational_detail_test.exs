defmodule LoginService.EducationalDetailTest do
  use LoginService.ModelCase

  alias LoginService.EducationalDetail

  @valid_attrs %{graduation: "some content", intermediate: "some content", senior_secondary: "some content", user_id: 42}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = EducationalDetail.changeset(%EducationalDetail{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = EducationalDetail.changeset(%EducationalDetail{}, @invalid_attrs)
    refute changeset.valid?
  end
end

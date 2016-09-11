defmodule LoginService.PersnalInformationTest do
  use LoginService.ModelCase

  alias LoginService.PersnalInformation

  @valid_attrs %{age: 42, city: "some content", contact_number: 42, dob: 42, hometown: "some content", name: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = PersnalInformation.changeset(%PersnalInformation{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = PersnalInformation.changeset(%PersnalInformation{}, @invalid_attrs)
    refute changeset.valid?
  end
end

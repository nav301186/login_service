defmodule LoginService.DetailTest do
  use LoginService.ModelCase

  alias LoginService.Detail

  @valid_attrs %{}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Detail.changeset(%Detail{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Detail.changeset(%Detail{}, @invalid_attrs)
    refute changeset.valid?
  end
end

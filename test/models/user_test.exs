defmodule LoginService.UserTest do
  use LoginService.ModelCase

  alias LoginService.User


  @valid_attrs %{email: "nav@gmail.com", password: Comeonin.Bcrypt.hashpwsalt("123456"),age: 42, gender: "M", name: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    IO.puts "Testing the change set"
    changeset = User.changeset(%User{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = User.changeset(%User{}, @invalid_attrs)
    refute changeset.valid?
  end
end

defmodule LoginService.LoginTest do
  use LoginService.ModelCase


    alias LoginService.User
    alias LoginService.Repo

    # @valid_attrs %{age: 42, gender: "some content", name: "some content", email: "nav@gmail.com", password: "123"}
    # @invalid_attrs %{}

    test "login with valid credentials" do
      password = "1234567"
      email = "nav123@gmail.com"
      crypted_password = Comeonin.Bcrypt.hashpwsalt(password)
      user = Repo.insert! %User{email: email, password: "password", crypted_password: crypted_password}

      {:ok, user} = LoginService.Login.login(%{"email" =>  email, "password" => password}, LoginService.Repo)
      assert user.email == email
    end
end

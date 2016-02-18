defmodule LoginService.GuardianSerializer do
  @behaviour Guardian.serializer
  alias LoginService.Repo
  alias LoginService.User

  def for_token(user = %User{}) do
    {:ok, "User:#{user.email}"}
  end

  def for_token(_) do
    {:error, "Unknow resource type"}
  end

  def from_token("User:" <> email) do
    {:ok, Repo.get_by(User, email: email)}
  end

  def from_token(_) do
    {:error, "Unknown resource type"}
  end

end

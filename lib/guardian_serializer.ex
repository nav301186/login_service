defmodule LoginService.GuardianSerializer do
  @behaviour Guardian.serializer
  alias LoginService.Repo
  alias LoginService.User

  def for_token(user = %User{}) do
    {:ok, "User:#{user.id}"}
  end

  def for_token(_) do
    {:error, "Unknow resource type"}
  end

  def from_token("User:" <> id) do
    IO.puts "User:" <> id
    {:ok, Repo.get(User, String.to_integer(id))}
  end

  # def from_token(_) do
  #   {:error, "Unknown resource type"}
  # end

end

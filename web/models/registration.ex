defmodule LoginService.Registration do
  import Ecto.Changeset, only: [put_change: 3]

alias LoginService.PersnalInformation
  def create(changeset, repo) do
    {:ok, user}  =  changeset
          |> put_change(:crypted_password, hashed_password(changeset.params["password"]))
          |> repo.insert()

        PersnalInformation.changeset(%PersnalInformation{}, %{user_id: user.id}) |>  repo.insert()


         {:ok, user}
  end

    defp hashed_password(password) do
      Comeonin.Bcrypt.hashpwsalt(password)
    end
end

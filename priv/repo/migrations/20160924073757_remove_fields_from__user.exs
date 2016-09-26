defmodule LoginService.Repo.Migrations.RemoveFieldsFrom_User do
  use Ecto.Migration

  def change do
    alter table(:users) do
      remove :name
      remove :avatar
      remove :gender
      remove :age
    end
  end
end

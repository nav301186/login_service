defmodule LoginService.Repo.Migrations.RemoveUserNameFrom_User do
  use Ecto.Migration

  def change do
    alter table(:users) do
      remove :user_name
    end
  end
end

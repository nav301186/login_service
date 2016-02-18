defmodule LoginService.Repo.Migrations.AddFieldsToUsers do
  use Ecto.Migration

  def change do
    alter table(:users) do
      add :user_name, :string
      add :email, :string
      add :crypted_password, :string
      add :password, :string, virtual: true
    end
  end
end

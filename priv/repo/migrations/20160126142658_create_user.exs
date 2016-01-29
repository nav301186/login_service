defmodule LoginService.Repo.Migrations.CreateUser do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :name, :string
      add :age, :integer
      add :gender, :string

      timestamps
    end

  end
end

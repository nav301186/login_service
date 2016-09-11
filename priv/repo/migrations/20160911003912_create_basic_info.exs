defmodule LoginService.Repo.Migrations.CreateBasicInfo do
  use Ecto.Migration

  def change do
    alter table(:basic_infos) do

      add :user_id, references(:users)

      # timestamps
    end
    create index(:basic_infos, [:user_id])

  end
end

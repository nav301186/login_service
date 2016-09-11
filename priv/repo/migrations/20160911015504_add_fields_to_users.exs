defmodule LoginService.Repo.Migrations.AddFieldsToUsers do
  use Ecto.Migration

  def change do
    alter table(:users) do
      add :basic_info_id, references(:basic_infos)
      # timestamps
    end

  end
end

defmodule LoginService.Repo.Migrations.CreateEducationalDetail do
  use Ecto.Migration

  def change do
    create table(:educational_details) do
      add :graduation, :string
      add :intermediate, :string
      add :senior_secondary, :string
      add :user_id, :integer

      timestamps
    end

  end
end

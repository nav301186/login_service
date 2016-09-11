defmodule LoginService.Repo.Migrations.AddUserIdToPersnalDetail do
  use Ecto.Migration

  def change do
    alter table(:persnal_information) do
      add :user_id, :integer
    end
  end
end

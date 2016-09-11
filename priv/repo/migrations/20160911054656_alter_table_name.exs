defmodule LoginService.Repo.Migrations.AlterTableName do
  use Ecto.Migration

  def change do
    create table(:persnal_informations) do
      add :name, :string
      add :age, :integer
      add :contact_number, :integer
      add :dob, :integer
      add :city, :string
      add :hometown, :string
      add :user_id, :integer
      timestamps
    end

  end
end

defmodule LoginService.Repo.Migrations.CreatePersnalInformation do
  use Ecto.Migration

  def change do
    create table(:persnal_information) do
      add :name, :string
      add :age, :integer
      add :contact_number, :integer
      add :dob, :integer
      add :city, :string
      add :hometown, :string

      timestamps
    end

  end
end

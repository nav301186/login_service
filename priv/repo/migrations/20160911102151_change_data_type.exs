defmodule LoginService.Repo.Migrations.ChangeDataType do
  use Ecto.Migration

  def change do
      alter table(:persnal_information) do
      modify :contact_number, :string
end
  end
end

defmodule LoginService.PersnalInformation do
  use LoginService.Web, :model

  schema "persnal_information" do
    field :name, :string
    field :age, :integer
    field :contact_number, :string
    field :dob, :integer
    field :city, :string
    field :hometown, :string
    field :user_id, :integer
    timestamps
  end

  @required_fields ~w()
  @optional_fields ~w(user_id name age contact_number dob city hometown)

  @doc """
  Creates a changeset based on the `model` and `params`.

  If no params are provided, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields, @optional_fields)
  end
end

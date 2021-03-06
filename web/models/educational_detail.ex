defmodule LoginService.EducationalDetail do
  use LoginService.Web, :model

  schema "educational_details" do
    field :graduation, :string
    field :intermediate, :string
    field :senior_secondary, :string
    field :user_id, :integer

    timestamps
  end

  @required_fields ~w(user_id)
  @optional_fields ~w(graduation intermediate senior_secondary)

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

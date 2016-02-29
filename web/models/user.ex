defmodule LoginService.User do
  use LoginService.Web, :model
  use Arc.Ecto.Model

  schema "users" do
    field :name, :string
    field :age, :integer
    field :gender, :string
    field :user_name, :string
    field :email, :string
    field :crypted_password, :string
    field :password, :string, virtual: true
    field :avatar, LoginService.Avatar.Type
    timestamps
  end

  @required_fields ~w(email)
  @optional_fields ~w(name age gender)

  @required_file_fields ~w()
  @optional_file_fields ~w(avatar)

  @doc """
  Creates a changeset based on the `model` and `params`.

  If no params are provided, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields, @optional_fields)
    |> cast_attachments(params, @required_file_fields, @optional_file_fields)
    # |> unique_constraints(:email)
    # |> validate_format(:email, -r/@/)
    # |> validate_length(:password, min: 5)
  end

  # def generate_avatar_url(path) do
  #    documents_path <> "?token=" <> :token
  # end

end

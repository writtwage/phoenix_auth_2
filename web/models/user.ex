defmodule AppName.User do
  use AppName.Web, :model
  import Comeonin.Bcrypt
  import Joken

  schema "users" do
    field :email, :string
    field :password_hash, :string
    field :password, :string, virtual: true

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:email, :password])
    |> unique_constraint(:email)
    |> validate_length(:password, min: 5)
    |> validate_required([:email, :password])
    |> hash_password
  end

  defp hash_password(changeset) do
    if password = get_change(changeset, :password) do
      changeset
      |> put_change(:password_hash, hashpwsalt(password))
    else
      changeset
    end
  end

  def generate_token(user) do
    %{user_id: user.id}
    |> token
    |> with_signer(hs256("secret-change-me"))
    |> sign
    |> get_compact
  end

  # validation_controller.ex calls User.verify_token
  # def verify_token(arg) do
  # end
end

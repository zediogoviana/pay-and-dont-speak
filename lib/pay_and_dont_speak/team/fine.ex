defmodule PayAndDontSpeak.Team.Fine do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "fines" do
    field :description, :string
    field :base_value, :integer
    field :multiplier, :float, default: 1.0
    has_many :player_fines, PayAndDontSpeak.Team.PlayerFine

    timestamps()
  end

  @doc false
  def changeset(fine, attrs) do
    fine
    |> cast(attrs, [:description, :base_value, :multiplier])
    |> validate_required([:description, :base_value, :multiplier])
  end
end

defmodule PayAndDontSpeak.Team.PlayerFine do
  use Ecto.Schema
  import Ecto.Changeset

  alias PayAndDontSpeak.Team.{Fine, Player}

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "player_fines" do
    field :paid, :boolean, default: false
    field :paid_at, :naive_datetime
    field :value, :integer

    belongs_to :player, Player, references: :id, foreign_key: :player_id, type: :binary_id
    belongs_to :fine, Fine, references: :id, foreign_key: :fine_id, type: :binary_id

    timestamps()
  end

  @doc false
  def changeset(fine, attrs) do
    fine
    |> cast(attrs, [:paid, :paid_at, :value, :player_id, :fine_id])
    |> validate_required([:paid, :value, :player_id, :fine_id])
    |> foreign_key_constraint(:fine_id)
    |> foreign_key_constraint(:player_id)
  end
end

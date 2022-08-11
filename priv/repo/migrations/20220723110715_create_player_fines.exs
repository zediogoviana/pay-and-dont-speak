defmodule PayAndDontSpeak.Repo.Migrations.CreatePlayerFines do
  use Ecto.Migration

  def change do
    create table(:player_fines, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :paid, :boolean, default: false, null: false
      add :paid_at, :naive_datetime
      add :value, :integer, null: false
      add :player_id, references(:players, on_delete: :nothing, type: :binary_id), null: false
      add :fine_id, references(:fines, on_delete: :nothing, type: :binary_id), null: false

      timestamps()
    end

    create index(:player_fines, [:player_id])
    create index(:player_fines, [:fine_id])
  end
end

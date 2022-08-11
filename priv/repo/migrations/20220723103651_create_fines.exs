defmodule PayAndDontSpeak.Repo.Migrations.CreateFines do
  use Ecto.Migration

  def change do
    create table(:fines, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :description, :string, null: false
      add :base_value, :integer, null: false
      add :multiplier, :float, null: false

      timestamps()
    end
  end
end

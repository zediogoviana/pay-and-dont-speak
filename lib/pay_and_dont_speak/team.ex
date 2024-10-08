defmodule PayAndDontSpeak.Team do
  @moduledoc false

  import Ecto.Query, warn: false
  alias PayAndDontSpeak.Repo

  alias PayAndDontSpeak.Team.Player
  alias PayAndDontSpeak.Team.Fine
  alias PayAndDontSpeak.Team.PlayerFine

  def list_debtors do
    player_fines =
      PlayerFine
      |> where([player_fine], not player_fine.paid)

    Player
    |> join(:right, [player], player_fine in subquery(player_fines),
      on: player.id == player_fine.player_id
    )
    |> preload(player_fines: ^{player_fines, :fine})
    |> distinct(true)
    |> Repo.all()
  end

  def list_players do
    Player
    |> join(:left, [player], player_fine in PlayerFine, on: player.id == player_fine.player_id)
    |> select([player, player_fine], %{
      id: player.id,
      name: player.name,
      total_amount: sum(player_fine.value)
    })
    |> group_by([player, player_fine], player.id)
    |> order_by([player, player_fine], desc: coalesce(sum(player_fine.value), 0))
    |> Repo.all()
  end

  def get_player!(id) do
    Repo.get!(Player, id)
    |> Repo.preload(player_fines: :fine)
  end

  def create_player(attrs \\ %{}) do
    %Player{}
    |> Player.changeset(attrs)
    |> Repo.insert()
  end

  def update_player(%Player{} = player, attrs) do
    player
    |> Player.changeset(attrs)
    |> Repo.update()
  end

  def delete_player(%Player{} = player) do
    Repo.delete(player)
  end

  def change_player(%Player{} = player, attrs \\ %{}) do
    Player.changeset(player, attrs)
  end

  def list_fines do
    Repo.all(Fine)
  end

  def get_fine!(id) do
    Repo.get!(Fine, id)
    |> Repo.preload(player_fines: :player)
  end

  def create_fine(attrs \\ %{}) do
    new_attrs =
      Map.merge(
        attrs,
        %{"base_value" => parse_currency_value(attrs["base_value"])}
      )

    %Fine{}
    |> Fine.changeset(new_attrs)
    |> Repo.insert()
  end

  def update_fine(%Fine{} = fine, attrs) do
    new_attrs =
      Map.merge(
        attrs,
        %{"base_value" => parse_currency_value(attrs["base_value"])}
      )

    fine
    |> Fine.changeset(new_attrs)
    |> Repo.update()
  end

  def delete_fine(%Fine{} = fine) do
    Repo.delete(fine)
  end

  def change_fine(%Fine{} = fine, attrs \\ %{}) do
    Fine.changeset(fine, attrs)
  end

  def total_value_collected_in_fines() do
    query = from p in PlayerFine, where: p.paid == true, select: sum(p.value)

    Repo.all(query)
    |> hd()
  end

  def list_player_fines do
    PlayerFine
    |> order_by([player_fine], desc: player_fine.inserted_at)
    |> Repo.all()
    |> Repo.preload([:fine, :player])
  end

  def get_player_fine!(id, preloads \\ []) do
    Repo.get!(PlayerFine, id)
    |> Repo.preload(preloads)
  end

  def get_last_recurring_player_fine(player_id, fine_id) do
    PlayerFine
    |> where(player_id: ^player_id, fine_id: ^fine_id)
    |> last(:inserted_at)
    |> Repo.one()
  end

  def add_fine_to_player(%{"fine_id" => fine_id, "player_id" => player_id} = attrs) do
    fine = get_fine!(fine_id)

    value =
      case get_last_recurring_player_fine(player_id, fine_id) do
        nil ->
          fine.base_value

        recurring_fine ->
          trunc(recurring_fine.value * fine.multiplier)
      end

    attrs_with_value = Map.merge(attrs, %{"value" => value})

    %PlayerFine{}
    |> PlayerFine.changeset(attrs_with_value)
    |> Repo.insert()
  end

  def create_player_fine(attrs \\ %{}) do
    %PlayerFine{}
    |> PlayerFine.changeset(attrs)
    |> Repo.insert()
  end

  def update_player_fine(%PlayerFine{} = player_fine, attrs) do
    paid_at =
      case attrs["paid"] do
        "true" -> DateTime.utc_now()
        _ -> nil
      end

    new_attrs =
      Map.merge(
        attrs,
        %{"value" => parse_currency_value(attrs["value"]), "paid_at" => paid_at}
      )

    player_fine
    |> PlayerFine.changeset(new_attrs)
    |> Repo.update()
  end

  def delete_player_fine(%PlayerFine{} = player_fine) do
    Repo.delete(player_fine)
  end

  def change_player_fine(%PlayerFine{} = player_fine, attrs \\ %{}) do
    PlayerFine.changeset(player_fine, attrs)
  end

  defp parse_currency_value(value) when is_binary(value) do
    value
    |> Float.parse()
    |> elem(0)
    |> then(&(&1 * 100))
    |> trunc()
  end

  defp parse_currency_value(value), do: value
end

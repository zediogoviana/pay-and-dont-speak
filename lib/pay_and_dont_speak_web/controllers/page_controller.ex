defmodule PayAndDontSpeakWeb.PageController do
  use PayAndDontSpeakWeb, :controller

  alias PayAndDontSpeak.Team
  alias PayAndDontSpeak.Team.PlayerFine

  def index(conn, _params) do
    debtors = Team.list_debtors()
    player_fine_changeset = Team.change_player_fine(%PlayerFine{})
    players = Team.list_players()
    fines = Team.list_fines()
    total_collected = Team.total_value_collected_in_fines()

    missing_payment =
      Enum.reduce(debtors, 0, fn debtor, acc ->
        debtor_total = debtor.player_fines |> Enum.map(& &1.value) |> Enum.sum()
        acc + debtor_total
      end)

    render(conn, "index.html",
      debtors: debtors,
      player_fine_changeset: player_fine_changeset,
      fines: fines,
      players: players,
      total_collected: total_collected,
      missing_payment: missing_payment
    )
  end
end

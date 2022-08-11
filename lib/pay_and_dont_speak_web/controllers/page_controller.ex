defmodule PayAndDontSpeakWeb.PageController do
  use PayAndDontSpeakWeb, :controller

  alias PayAndDontSpeak.Team
  alias PayAndDontSpeak.Team.PlayerFine

  def index(conn, _params) do
    debtors = Team.list_debtors()
    player_fine_changeset = Team.change_player_fine(%PlayerFine{})
    players = Team.list_players()
    fines = Team.list_fines()

    render(conn, "index.html",
      debtors: debtors,
      player_fine_changeset: player_fine_changeset,
      fines: fines,
      players: players
    )
  end
end

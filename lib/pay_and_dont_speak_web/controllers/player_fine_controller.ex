defmodule PayAndDontSpeakWeb.PlayerFineController do
  use PayAndDontSpeakWeb, :controller

  alias PayAndDontSpeak.Team

  def index(conn, _params) do
    player_fines = Team.list_player_fines()
    render(conn, "index.html", player_fines: player_fines)
  end

  def create(conn, %{"player_fine" => fine_params}) do
    case Team.add_fine_to_player(fine_params) do
      {:ok, fine} ->
        conn
        |> put_flash(:info, "Fine created successfully.")
        |> redirect(to: Routes.player_fine_path(conn, :show, fine))

      {:error, %Ecto.Changeset{} = changeset} ->
        debtors = Team.list_debtors()
        players = Team.list_players()
        fines = Team.list_fines()

        render(conn, PayAndDontSpeakWeb.PageView, "index.html",
          debtors: debtors,
          players: players,
          fines: fines,
          player_fine_changeset: changeset
        )
    end
  end

  def show(conn, %{"id" => id}) do
    fine = Team.get_player_fine!(id)
    render(conn, "show.html", fine: fine)
  end

  def edit(conn, %{"id" => id}) do
    fine = Team.get_player_fine!(id)
    changeset = Team.change_player_fine(fine)
    render(conn, "edit.html", fine: fine, changeset: changeset)
  end

  def update(conn, %{"id" => id, "player_fine" => fine_params}) do
    fine = Team.get_player_fine!(id)

    case Team.update_player_fine(fine, fine_params) do
      {:ok, fine} ->
        conn
        |> put_flash(:info, "Fine updated successfully.")
        |> redirect(to: Routes.player_fine_path(conn, :show, fine))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", fine: fine, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    fine = Team.get_player_fine!(id)
    {:ok, _fine} = Team.delete_player_fine(fine)

    conn
    |> put_flash(:info, "Fine deleted successfully.")
    |> redirect(to: Routes.player_fine_path(conn, :index))
  end
end

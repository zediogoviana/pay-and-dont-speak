defmodule PayAndDontSpeakWeb.FineController do
  use PayAndDontSpeakWeb, :controller

  alias PayAndDontSpeak.Team
  alias PayAndDontSpeak.Team.Fine

  def index(conn, _params) do
    fines = Team.list_fines()
    render(conn, "index.html", fines: fines)
  end

  def new(conn, _params) do
    changeset = Team.change_fine(%Fine{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"fine" => fine_params}) do
    case Team.create_fine(fine_params) do
      {:ok, fine} ->
        conn
        |> put_flash(:info, "Fine created successfully.")
        |> redirect(to: Routes.fine_path(conn, :show, fine))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    fine = Team.get_fine!(id)
    render(conn, "show.html", fine: fine)
  end

  def edit(conn, %{"id" => id}) do
    fine = Team.get_fine!(id)
    changeset = Team.change_fine(fine)
    render(conn, "edit.html", fine: fine, changeset: changeset)
  end

  def update(conn, %{"id" => id, "fine" => fine_params}) do
    fine = Team.get_fine!(id)

    case Team.update_fine(fine, fine_params) do
      {:ok, fine} ->
        conn
        |> put_flash(:info, "Fine updated successfully.")
        |> redirect(to: Routes.fine_path(conn, :show, fine))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", fine: fine, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    fine = Team.get_fine!(id)
    {:ok, _fine} = Team.delete_fine(fine)

    conn
    |> put_flash(:info, "Fine deleted successfully.")
    |> redirect(to: Routes.fine_path(conn, :index))
  end
end

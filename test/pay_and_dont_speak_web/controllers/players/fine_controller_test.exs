defmodule PayAndDontSpeakWeb.Players.FineControllerTest do
  use PayAndDontSpeakWeb.ConnCase

  import PayAndDontSpeak.TeamFixtures

  @create_attrs %{paid: true, paid_at: ~N[2022-07-22 11:07:00], value: 42}
  @update_attrs %{paid: false, paid_at: ~N[2022-07-23 11:07:00], value: 43}
  @invalid_attrs %{paid: nil, paid_at: nil, value: nil}

  describe "index" do
    test "lists all player_fines", %{conn: conn} do
      conn = get(conn, Routes.players_fine_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Player fines"
    end
  end

  describe "new fine" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.players_fine_path(conn, :new))
      assert html_response(conn, 200) =~ "New Fine"
    end
  end

  describe "create fine" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.players_fine_path(conn, :create), fine: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.players_fine_path(conn, :show, id)

      conn = get(conn, Routes.players_fine_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Fine"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.players_fine_path(conn, :create), fine: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Fine"
    end
  end

  describe "edit fine" do
    setup [:create_fine]

    test "renders form for editing chosen fine", %{conn: conn, fine: fine} do
      conn = get(conn, Routes.players_fine_path(conn, :edit, fine))
      assert html_response(conn, 200) =~ "Edit Fine"
    end
  end

  describe "update fine" do
    setup [:create_fine]

    test "redirects when data is valid", %{conn: conn, fine: fine} do
      conn = put(conn, Routes.players_fine_path(conn, :update, fine), fine: @update_attrs)
      assert redirected_to(conn) == Routes.players_fine_path(conn, :show, fine)

      conn = get(conn, Routes.players_fine_path(conn, :show, fine))
      assert html_response(conn, 200)
    end

    test "renders errors when data is invalid", %{conn: conn, fine: fine} do
      conn = put(conn, Routes.players_fine_path(conn, :update, fine), fine: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Fine"
    end
  end

  describe "delete fine" do
    setup [:create_fine]

    test "deletes chosen fine", %{conn: conn, fine: fine} do
      conn = delete(conn, Routes.players_fine_path(conn, :delete, fine))
      assert redirected_to(conn) == Routes.players_fine_path(conn, :index)

      assert_error_sent 404, fn ->
        get(conn, Routes.players_fine_path(conn, :show, fine))
      end
    end
  end

  defp create_fine(_) do
    fine = fine_fixture()
    %{fine: fine}
  end
end

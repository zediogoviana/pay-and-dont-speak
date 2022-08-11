defmodule PayAndDontSpeakWeb.FineControllerTest do
  use PayAndDontSpeakWeb.ConnCase

  import PayAndDontSpeak.TeamFixtures

  @create_attrs %{base_value: 42, description: "some description", multiplier: 120.5}
  @update_attrs %{base_value: 43, description: "some updated description", multiplier: 456.7}
  @invalid_attrs %{base_value: nil, description: nil, multiplier: nil}

  describe "index" do
    test "lists all fines", %{conn: conn} do
      conn = get(conn, Routes.fine_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Fines"
    end
  end

  describe "new fine" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.fine_path(conn, :new))
      assert html_response(conn, 200) =~ "New Fine"
    end
  end

  describe "create fine" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.fine_path(conn, :create), fine: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.fine_path(conn, :show, id)

      conn = get(conn, Routes.fine_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Fine"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.fine_path(conn, :create), fine: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Fine"
    end
  end

  describe "edit fine" do
    setup [:create_fine]

    test "renders form for editing chosen fine", %{conn: conn, fine: fine} do
      conn = get(conn, Routes.fine_path(conn, :edit, fine))
      assert html_response(conn, 200) =~ "Edit Fine"
    end
  end

  describe "update fine" do
    setup [:create_fine]

    test "redirects when data is valid", %{conn: conn, fine: fine} do
      conn = put(conn, Routes.fine_path(conn, :update, fine), fine: @update_attrs)
      assert redirected_to(conn) == Routes.fine_path(conn, :show, fine)

      conn = get(conn, Routes.fine_path(conn, :show, fine))
      assert html_response(conn, 200) =~ "some updated description"
    end

    test "renders errors when data is invalid", %{conn: conn, fine: fine} do
      conn = put(conn, Routes.fine_path(conn, :update, fine), fine: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Fine"
    end
  end

  describe "delete fine" do
    setup [:create_fine]

    test "deletes chosen fine", %{conn: conn, fine: fine} do
      conn = delete(conn, Routes.fine_path(conn, :delete, fine))
      assert redirected_to(conn) == Routes.fine_path(conn, :index)

      assert_error_sent 404, fn ->
        get(conn, Routes.fine_path(conn, :show, fine))
      end
    end
  end

  defp create_fine(_) do
    fine = fine_fixture()
    %{fine: fine}
  end
end

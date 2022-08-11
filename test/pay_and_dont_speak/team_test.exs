defmodule PayAndDontSpeak.TeamTest do
  use PayAndDontSpeak.DataCase

  alias PayAndDontSpeak.Team

  describe "players" do
    alias PayAndDontSpeak.Team.Player

    import PayAndDontSpeak.TeamFixtures

    @invalid_attrs %{name: nil}

    test "list_players/0 returns all players" do
      player = player_fixture()
      assert Team.list_players() == [player]
    end

    test "get_player!/1 returns the player with given id" do
      player = player_fixture()
      assert Team.get_player!(player.id) == player
    end

    test "create_player/1 with valid data creates a player" do
      valid_attrs = %{name: "some name"}

      assert {:ok, %Player{} = player} = Team.create_player(valid_attrs)
      assert player.name == "some name"
    end

    test "create_player/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Team.create_player(@invalid_attrs)
    end

    test "update_player/2 with valid data updates the player" do
      player = player_fixture()
      update_attrs = %{name: "some updated name"}

      assert {:ok, %Player{} = player} = Team.update_player(player, update_attrs)
      assert player.name == "some updated name"
    end

    test "update_player/2 with invalid data returns error changeset" do
      player = player_fixture()
      assert {:error, %Ecto.Changeset{}} = Team.update_player(player, @invalid_attrs)
      assert player == Team.get_player!(player.id)
    end

    test "delete_player/1 deletes the player" do
      player = player_fixture()
      assert {:ok, %Player{}} = Team.delete_player(player)
      assert_raise Ecto.NoResultsError, fn -> Team.get_player!(player.id) end
    end

    test "change_player/1 returns a player changeset" do
      player = player_fixture()
      assert %Ecto.Changeset{} = Team.change_player(player)
    end
  end

  describe "fines" do
    alias PayAndDontSpeak.Team.Fine

    import PayAndDontSpeak.TeamFixtures

    @invalid_attrs %{base_value: nil, description: nil, multiplier: nil}

    test "list_fines/0 returns all fines" do
      fine = fine_fixture()
      assert Team.list_fines() == [fine]
    end

    test "get_fine!/1 returns the fine with given id" do
      fine = fine_fixture()
      assert Team.get_fine!(fine.id) == fine
    end

    test "create_fine/1 with valid data creates a fine" do
      valid_attrs = %{base_value: 42, description: "some description", multiplier: 120.5}

      assert {:ok, %Fine{} = fine} = Team.create_fine(valid_attrs)
      assert fine.base_value == 42
      assert fine.description == "some description"
      assert fine.multiplier == 120.5
    end

    test "create_fine/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Team.create_fine(@invalid_attrs)
    end

    test "update_fine/2 with valid data updates the fine" do
      fine = fine_fixture()
      update_attrs = %{base_value: 43, description: "some updated description", multiplier: 456.7}

      assert {:ok, %Fine{} = fine} = Team.update_fine(fine, update_attrs)
      assert fine.base_value == 43
      assert fine.description == "some updated description"
      assert fine.multiplier == 456.7
    end

    test "update_fine/2 with invalid data returns error changeset" do
      fine = fine_fixture()
      assert {:error, %Ecto.Changeset{}} = Team.update_fine(fine, @invalid_attrs)
      assert fine == Team.get_fine!(fine.id)
    end

    test "delete_fine/1 deletes the fine" do
      fine = fine_fixture()
      assert {:ok, %Fine{}} = Team.delete_fine(fine)
      assert_raise Ecto.NoResultsError, fn -> Team.get_fine!(fine.id) end
    end

    test "change_fine/1 returns a fine changeset" do
      fine = fine_fixture()
      assert %Ecto.Changeset{} = Team.change_fine(fine)
    end
  end

  describe "player_fines" do
    alias PayAndDontSpeak.Team.Player.Fine

    import PayAndDontSpeak.TeamFixtures

    @invalid_attrs %{paid: nil, paid_at: nil, value: nil}

    test "list_player_fines/0 returns all player_fines" do
      fine = fine_fixture()
      assert Team.list_player_fines() == [fine]
    end

    test "get_fine!/1 returns the fine with given id" do
      fine = fine_fixture()
      assert Team.get_fine!(fine.id) == fine
    end

    test "create_fine/1 with valid data creates a fine" do
      valid_attrs = %{paid: true, paid_at: ~N[2022-07-22 11:07:00], value: 42}

      assert {:ok, %Fine{} = fine} = Team.create_fine(valid_attrs)
      assert fine.paid == true
      assert fine.paid_at == ~N[2022-07-22 11:07:00]
      assert fine.value == 42
    end

    test "create_fine/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Team.create_fine(@invalid_attrs)
    end

    test "update_fine/2 with valid data updates the fine" do
      fine = fine_fixture()
      update_attrs = %{paid: false, paid_at: ~N[2022-07-23 11:07:00], value: 43}

      assert {:ok, %Fine{} = fine} = Team.update_fine(fine, update_attrs)
      assert fine.paid == false
      assert fine.paid_at == ~N[2022-07-23 11:07:00]
      assert fine.value == 43
    end

    test "update_fine/2 with invalid data returns error changeset" do
      fine = fine_fixture()
      assert {:error, %Ecto.Changeset{}} = Team.update_fine(fine, @invalid_attrs)
      assert fine == Team.get_fine!(fine.id)
    end

    test "delete_fine/1 deletes the fine" do
      fine = fine_fixture()
      assert {:ok, %Fine{}} = Team.delete_fine(fine)
      assert_raise Ecto.NoResultsError, fn -> Team.get_fine!(fine.id) end
    end

    test "change_fine/1 returns a fine changeset" do
      fine = fine_fixture()
      assert %Ecto.Changeset{} = Team.change_fine(fine)
    end
  end
end

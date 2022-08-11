defmodule PayAndDontSpeak.TeamFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `PayAndDontSpeak.Team` context.
  """

  @doc """
  Generate a player.
  """
  def player_fixture(attrs \\ %{}) do
    {:ok, player} =
      attrs
      |> Enum.into(%{
        name: "some name"
      })
      |> PayAndDontSpeak.Team.create_player()

    player
  end

  @doc """
  Generate a fine.
  """
  def fine_fixture(attrs \\ %{}) do
    {:ok, fine} =
      attrs
      |> Enum.into(%{
        base_value: 42,
        description: "some description",
        multiplier: 120.5
      })
      |> PayAndDontSpeak.Team.create_fine()

    fine
  end

  @doc """
  Generate a player_fine.
  """
  def player_fine_fixture(attrs \\ %{}) do
    {:ok, fine} =
      attrs
      |> Enum.into(%{
        paid: true,
        paid_at: ~N[2022-07-22 11:07:00],
        value: 42
      })
      |> PayAndDontSpeak.Team.create_fine()

    fine
  end
end

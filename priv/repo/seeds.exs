# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     PayAndDontSpeak.Repo.insert!(%PayAndDontSpeak.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

alias PayAndDontSpeak.Team

players =
  for _player <- 1..20 do
    Team.create_player(%{"name" => Faker.Person.name()})
    |> elem(1)
  end

fines =
  for _fine <- 1..20 do
    Team.create_fine(%{
      "description" => Faker.Lorem.sentence(),
      "base_value" => Faker.Random.Elixir.random_between(10, 1000),
      "multiplier" => Float.floor(Faker.Random.Elixir.random_uniform(), 2)
    })
    |> elem(1)
  end

for player_fine <- 1..20 do
  Team.create_player_fine(%{
    "paid" => Enum.random([true, false]),
    "paid_at" => Faker.DateTime.backward(1),
    "value" => Faker.Random.Elixir.random_between(10, 1000),
    "player_id" => Enum.random(players).id,
    "fine_id" => Enum.random(fines).id
  })
end

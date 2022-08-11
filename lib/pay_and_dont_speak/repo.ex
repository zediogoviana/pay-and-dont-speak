defmodule PayAndDontSpeak.Repo do
  use Ecto.Repo,
    otp_app: :pay_and_dont_speak,
    adapter: Ecto.Adapters.Postgres
end

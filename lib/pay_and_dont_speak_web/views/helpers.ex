defmodule PayAndDontSpeakWeb.Helpers do
  def format_currency(nil), do: "0€"

  def format_currency(integer_value) do
    "#{integer_value / 100}€"
  end

  def format_paid_at(date) do
    if date, do: Date.to_string(date), else: "-"
  end

  def format_fine_paid(paid) do
    if paid, do: "✅", else: "❌"
  end
end

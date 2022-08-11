defmodule PayAndDontSpeakWeb.FallbackController do
  use Phoenix.Controller

  def call(conn, {:error, :not_found}) do
    conn
    |> put_status(:not_found)
    |> render("error/404.html")
  end

  def call(conn, {:error, :unauthorized}) do
    conn
    |> put_status(403)
    |> put_view(PayAndDontSpeakWeb.ErrorView)
    |> render(:"403")
  end
end

defmodule PayAndDontSpeakWeb.UserRegistrationController do
  use PayAndDontSpeakWeb, :controller

  alias PayAndDontSpeak.Accounts
  alias PayAndDontSpeak.Accounts.User
  alias PayAndDontSpeakWeb.UserAuth

  @register_active Application.compile_env!(:pay_and_dont_speak, :register_active)

  def new(conn, _params) do
    if @register_active === "true" do
      changeset = Accounts.change_user_registration(%User{})
      render(conn, "new.html", changeset: changeset)
    else
      render_error(conn)
    end
  end

  def create(conn, %{"user" => user_params}) do
    if @register_active === "true" do
      case Accounts.register_user(user_params) do
        {:ok, user} ->
          {:ok, _} =
            Accounts.deliver_user_confirmation_instructions(
              user,
              &Routes.user_confirmation_url(conn, :edit, &1)
            )

          conn
          |> put_flash(:info, "User created successfully.")
          |> UserAuth.log_in_user(user)

        {:error, %Ecto.Changeset{} = changeset} ->
          render(conn, "new.html", changeset: changeset)
      end
    else
      render_error(conn)
    end
  end

  defp render_error(conn) do
    conn
    |> put_status(:not_found)
    |> put_root_layout(false)
    |> put_view(PayAndDontSpeakWeb.ErrorView)
    |> render(:"404")
  end
end

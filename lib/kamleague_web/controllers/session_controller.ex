defmodule KamleagueWeb.SessionController do
  use KamleagueWeb, :controller

  def new(conn, _params) do
    changeset = Kamleague.Accounts.User.changeset(%Kamleague.Accounts.User{}, %{})

    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"user" => user_params}) do
    conn
    |> Pow.Plug.authenticate_user(user_params)
    |> case do
      {:ok, conn} ->
        Kamleague.Accounts.update_user_ip(conn)

        conn
        |> redirect(to: Routes.page_path(conn, :index))

      {:error, conn} ->
        changeset = Pow.Plug.change_user(conn, conn.params["user"])

        conn
        |> put_flash(:info, "Invalid email or password")
        |> render("new.html", changeset: changeset)
    end
  end

  def delete(conn, _params) do
    {:ok, conn} = Pow.Plug.clear_authenticated_user(conn)

    redirect(conn, to: Routes.page_path(conn, :index))
  end
end

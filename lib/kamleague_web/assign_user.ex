defmodule KamleagueWeb.AssignUser do
  import Plug.Conn

  alias Kamleague.Accounts.User
  alias Kamleague.Repo

  @spec init(any) :: any
  def init(opts), do: opts

  @spec call(Plug.Conn.t(), any) :: Plug.Conn.t()
  def call(conn, _params) do
    case Pow.Plug.current_user(conn) do
      %User{} = user ->
        conn
        |> assign(:current_user, Repo.preload(user, :player))
        |> assign(:maps, Kamleague.Leagues.list_maps())

      _ ->
        assign(conn, :current_user, nil)
    end
  end
end

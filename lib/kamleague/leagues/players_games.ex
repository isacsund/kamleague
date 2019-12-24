defmodule Kamleague.Leagues.PlayersGames do
  use Ecto.Schema

  import Ecto.Changeset

  schema "players_games" do
    belongs_to :player_info, Kamleague.Leagues.Player, foreign_key: :player_id
    belongs_to :game, Kamleague.Leagues.Game
    field :location, :integer
    field :win, :boolean

    timestamps()
  end

  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:player_id, :game_id, :location, :win])
    |> validate_required([:player_id, :game_id, :location, :win])
  end
end

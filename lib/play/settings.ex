defmodule Play.Settings do
  use Ecto.Schema
  @primary_key {:user_name, :string, autogenerate: false}

  schema "settings" do
    field :odds_change_action, :string, default: "oddsChangeHigher"
    field :odds_format, :string, default: "decimal"
    field :show_odds_change_options, :boolean, default: true

    timestamps()
  end

  def changeset(settings, params \\ %{}) do
    settings
    |> Ecto.Changeset.cast(params, [:odds_format, :odds_change_action, :show_odds_change_options])
    |> Ecto.Changeset.validate_required([:odds_format, :odds_change_action, :show_odds_change_options])
  end

  def upsert(%Ecto.Changeset{data: %Play.Settings{}} = settings) do
    Play.Repo.insert settings, on_conflict: :replace_all_except_primary_key, conflict_target: :user_name
  end

  def get_or_default(user_name) do
    case settings = Play.Repo.get(__MODULE__, user_name) do
       nil -> %__MODULE__{user_name: user_name}
       _ -> settings
    end
  end
end

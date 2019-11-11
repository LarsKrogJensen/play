defmodule Play.Repo.Migrations.CreateTableSettings do
  use Ecto.Migration

  def change do
    create table(:settings, primary_key: false) do
      add :user_name, :string, primary_key: true, null: false
      add :odds_change_action, :string, null: false
      add :odds_format, :string, null: false
      add :show_odds_change_options, :boolean, null: false, default: true

      timestamps()
    end
  end
end

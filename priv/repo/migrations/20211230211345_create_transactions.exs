defmodule JayaTech.Repo.Migrations.CreateTransactions do
  use Ecto.Migration

  def change do
    create table(:transactions) do
      add :origin_currency, :string
      add :origin_value, :decimal
      add :destination_currency, :string
      add :destination_value, :decimal
      add :conversion_rate_used, :string
      add :date_time_utc, :utc_datetime
      add :user_id, references(:users)

      timestamps()
    end
  end
end

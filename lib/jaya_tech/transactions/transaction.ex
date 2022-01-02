defmodule JayaTech.Transactions.Transaction do
  use Ecto.Schema
  import Ecto.Changeset

  alias JayaTech.Accounts.User

  schema "transactions" do
    field :origin_currency, :string
    field :origin_value, :decimal
    field :destination_currency, :string
    field :destination_value, :decimal
    field :conversion_rate_used, :string
    field :date_time_utc, :utc_datetime
    belongs_to :user, User

    timestamps()
  end

  @doc false
  def changeset(transaction, attrs) do
    fields = ~w(origin_currency origin_value destination_currency
        destination_value conversion_rate_used date_time_utc user_id)a

    transaction
    |> cast(attrs, fields)
    |> validate_required(fields)
  end
end

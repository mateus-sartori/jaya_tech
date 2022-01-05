defmodule JayaTech.TransactionsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `JayaTech.Transactions` context.
  """

  @doc """
  Generate a transaction.
  """
  def transaction_fixture(attrs \\ %{}) do
    {:ok, transaction} =
      attrs
      |> Enum.into(%{
        origin_currency: "USD",
        origin_value: Decimal.new(10),
        destination_currency: "BRL",
        destination_value: Decimal.new(50),
        conversion_rate_used: "5",
        date_time_utc: DateTime.utc_now()
      })
      |> Map.put_new_lazy(:user_id, fn ->
        user = JayaTech.AccountsFixtures.user_fixture()
        user.id
      end)
      |> JayaTech.Transactions.create_transaction()

    transaction
  end
end

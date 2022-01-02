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
        origin_currency: "some origin_currency"
      })
      |> JayaTech.Transactions.create_transaction()

    transaction
  end
end

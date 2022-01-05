defmodule JayaTech.TransactionsTest do
  use JayaTech.DataCase

  alias JayaTech.Transactions
  import JayaTech.Factory

  describe "transactions" do
    alias JayaTech.Transactions.Transaction

    import JayaTech.TransactionsFixtures
    import JayaTech.AccountsFixtures

    @invalid_attrs %{}

    test "list_transactions/0 returns all transactions" do
      transaction = transaction_fixture()
      assert Transactions.list_transactions() == [transaction]
    end

    test "list_transactions_by_user/0 returns all transactions by user" do
      user = user_fixture()
      transaction = transaction_fixture(user_id: user.id)
      assert Transactions.list_by_user(user.id) == [transaction]
    end

    test "create_transaction/1 with valid data creates a transaction" do
      user = user_fixture()
      transaction = %{
        conversion_rate_used: "USD 1.131548 and BRL 6.445294",
        date_time_utc: DateTime.utc_now(),
        destination_currency: "BRL",
        destination_value: 14240.00,
        origin_currency: "USD",
        origin_value: 2500.00,
        user_id: user.id
      }

      assert {:ok, %Transaction{}} = Transactions.create_transaction(transaction)
    end

    test "create_transaction/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Transactions.create_transaction(@invalid_attrs)
    end
  end
end

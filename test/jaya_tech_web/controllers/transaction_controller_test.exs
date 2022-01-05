defmodule JayaTechWeb.TransactionControllerTest do
  use JayaTechWeb.ConnCase

  import JayaTech.TransactionsFixtures
  import JayaTech.AccountsFixtures

  alias JayaTech.Transactions

  alias JayaTech.Transactions.Transaction

  @create_attrs %{
    origin_currency: "usd",
    destination_currency: "brl",
    origin_value: 2500.00
  }

  @invalid_attrs %{origin_currency: nil, destination_currency: nil, origin_value: nil}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all transactions", %{conn: conn} do
      conn = get(conn, Routes.transaction_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create transaction" do
    test "renders transaction when data is valid", %{conn: conn} do
      conn = post(conn, Routes.transaction_path(conn, :create), transaction: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.transaction_path(conn, :show, id))

      transaction_info =
        Transactions.convert_currency(
          "usd",
          "brl",
          2500
        )
        |> elem(1)

      conversion_rate_used = transaction_info[:conversion_rate_used]
      destination_currency = transaction_info[:destination_currency]
      destination_value = transaction_info[:destination_value]
      origin_currency = transaction_info[:origin_currency]
      origin_value = transaction_info[:origin_value]
      date_time_utc = transaction_info[:date_time_utc]

      assert %{
               "conversion_rate_used" => conversion_rate_used,
               "destination_currency" => destination_currency,
               "destination_value" => destination_value,
               "id" => ^id,
               "origin_currency" => origin_currency,
               "origin_value" => origin_value,
               "date_time_utc" => date_time_utc
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when currencies is invalid", %{conn: conn} do
      conn = post(conn, Routes.transaction_path(conn, :create), transaction: @invalid_attrs)

      assert(
        json_response(conn, 200)["errors"] == %{
          "details" => "Unsupported currency",
          "status" => 200
        }
      )
    end
  end

  describe "delete transaction" do
    setup [:create_transaction]

    test "deletes chosen transaction", %{conn: conn, transaction: transaction} do
      conn = delete(conn, Routes.transaction_path(conn, :delete, transaction))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.transaction_path(conn, :show, transaction))
      end
    end
  end

  defp create_transaction(_) do
    transaction = transaction_fixture()
    %{transaction: transaction}
  end
end

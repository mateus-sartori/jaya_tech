defmodule JayaTechWeb.TransactionController do
  use JayaTechWeb, :controller

  alias JayaTech.Transactions
  alias JayaTech.Transactions.Transaction

  action_fallback JayaTechWeb.FallbackController

  def index(conn, _params) do
    transactions = Transactions.list_transactions()
    render(conn, "index.json", transactions: transactions)
  end

  def index_by_user(conn, %{"user_id" => user_id}) do
    transactions = Transactions.list_by_user(user_id)
    render(conn, "index.json", transactions: transactions)
  end

  def create(conn, %{"transaction" => transaction_params}) do
    transaction_info =
      Transactions.convert_currency(
        transaction_params["origin_currency"],
        transaction_params["destination_currency"],
        transaction_params["origin_value"]
      )

    case transaction_info do
      {:ok, transaction_info} ->
        with {:ok, %Transaction{} = transaction} <-
               Transactions.create_transaction(transaction_info) do
          conn
          |> put_status(:created)
          |> render("show.json", transaction: transaction)
        end

      {:error, response} ->
        {:error_external_api, %{message: response[:body], status: response[:status]}}
    end
  end
end

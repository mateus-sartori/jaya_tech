defmodule JayaTechWeb.TransactionView do
  use JayaTechWeb, :view
  alias JayaTechWeb.TransactionView

  def render("index.json", %{transactions: transactions}) do
    %{data: render_many(transactions, TransactionView, "transaction.json")}
  end

  def render("show.json", %{transaction: transaction}) do
    %{data: render_one(transaction, TransactionView, "transaction.json")}
  end

  def render("transaction.json", %{transaction: transaction}) do
    %{
      id: transaction.id,
      user_id: transaction.user_id,
      origin_currency: transaction.origin_currency,
      origin_value: transaction.origin_value,
      destination_currency: transaction.destination_currency,
      destination_value: transaction.destination_value,
      conversion_rate_used: transaction.conversion_rate_used,
      date_time_utc: transaction.date_time_utc
    }
  end
end

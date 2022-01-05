defmodule JayaTech.Transactions do
  @moduledoc """
  The Transactions context.
  """

  import Ecto.Query, warn: false
  alias JayaTech.Repo
  alias JayaTech.Requests
  alias JayaTech.Accounts

  alias JayaTech.Transactions.Transaction

  def get_transaction!(id) do
    Transaction
    |> preload(:user)
    |> Repo.get!(id)
  end

  def list_transactions do
    Repo.all(Transaction)
  end

  @spec list_by_user(number) :: any
  def list_by_user(user_id) do
    Transaction
    |> where(user_id: ^user_id)
    |> Repo.all()
  end

  def create_transaction(attrs \\ %{}) do
    %Transaction{}
    |> Transaction.changeset(attrs)
    |> Repo.insert()
  end

  @spec convert_currency(binary, binary, float) ::
          {:ok,
           %{
             conversion_rate_used: binary,
             date_time_utc: DateTime.t(),
             destination_currency: binary,
             destination_value: float,
             origin_currency: binary,
             origin_value: number,
             user_id: any
           }}
          | {:error, list(status: binary, body: map)}
  def convert_currency(origin_currency, destination_currency, origin_value) do
    with {:ok, response} <- Requests.get_currency_rates() do
      origin_currency = if origin_currency, do: String.upcase(origin_currency)
      destination_currency = if origin_currency, do: String.upcase(destination_currency)
      rates = response.body["rates"]

      rates =
        if not is_nil(rates), do: check_currencies(origin_currency, destination_currency, rates)

      if rates do
        performs_calculation(origin_currency, destination_currency, origin_value, response)
      else
        {:error,
         status: response.status || 400, body: response.body["error"] || "Unsupported currency"}
      end
    end
  end

  defp check_currencies(origin_currency, destination_currency, rates) do
    Enum.all?(
      [origin_currency, destination_currency],
      &Map.has_key?(rates, &1)
    )
  end

  defp performs_calculation(origin_currency, destination_currency, origin_value, response) do
    if response.status in 200..299 do
      result =
        origin_value * (1 / response.body["rates"][origin_currency]) *
          response.body["rates"][destination_currency]

      {:ok,
       %{
         user_id: Accounts.get_random(),
         destination_value: Float.ceil(result, 2),
         origin_currency: origin_currency,
         origin_value: origin_value,
         destination_currency: destination_currency,
         conversion_rate_used:
           "#{String.upcase(origin_currency)} #{response.body["rates"][origin_currency]} and #{String.upcase(destination_currency)} #{response.body["rates"][destination_currency]}",
         date_time_utc: DateTime.utc_now()
       }}
    else
      {:error, status: response.status, body: response.body["error"]}
    end
  end
end

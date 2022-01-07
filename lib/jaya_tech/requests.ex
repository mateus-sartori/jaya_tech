defmodule JayaTech.Requests do
  use Tesla, only: [:get], docs: false

  plug Tesla.Middleware.BaseUrl, "http://api.exchangeratesapi.io/v1"
  plug Tesla.Middleware.JSON
  plug JayaTech.Requests.Case

  @spec get_currency_rates() :: Tesla.Env.result()
  def get_currency_rates() do
    get("/latest", query: [access_key: "1692589819a6dffba85fd137e5132cec", base: "EUR"])
  end
end

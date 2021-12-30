defmodule JayaTechWeb.Router do
  use JayaTechWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", JayaTechWeb do
    pipe_through :api
  end
end

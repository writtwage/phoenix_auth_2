defmodule AppName.Router do
  use AppName.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  pipeline :authenticated do
    plug Mellon, validator: {AppName.Validation, :validate, []}, header: "api-token"
  end

  scope "/", AppName do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
  end

  # Other scopes may use custom stacks.
  scope "/api", AppName do
    pipe_through :api
    pipe_through :authenticated

    get "/auth/validate", SessionController, :validate
    # TRY WITH except
    resources "/users", UserController #, except: [:new, :edit]

    post "/auth", RegistrationController, :create

    get "/auth/login", SessionController, :login
  end
end

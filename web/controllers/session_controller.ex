defmodule AppName.SessionController do
  use AppName.Web, :controller

  alias AppName.User

  def login(conn, %{"user" => user_params}) do
    if user = Repo.get_by(User, email: user_params["email"]) do

      token = User.generate_token(user)

      conn
      |> put_status(200)
      |> render(AppName.SessionView, "session.json", token: token)
    else
      conn
      |> put_status(:unprocessable_entity)
      |> render(AppName.SessionView, "error.json", message: "Nope")
    end
  end

  def validate(conn, _params) do
    conn
    |> put_status(200)
    |> render(AppName.UserView, "show.json", user: %User{email: "test"})
  end  
end

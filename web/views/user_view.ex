defmodule AppName.UserView do
  use AppName.Web, :view

  def render("index.json", %{users: users}) do
    %{data: render_many(users, AppName.UserView, "user.json")}
  end

  def render("show.json", %{user: user}) do
    %{data: render_one(user, AppName.UserView, "user.json")}
  end

  def render("user.json", %{user: user}) do
    %{id: user.id,
      email: user.email,
      password_hash: user.password_hash}
  end
end

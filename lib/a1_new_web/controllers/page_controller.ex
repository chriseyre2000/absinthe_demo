defmodule A1NewWeb.PageController do
  use A1NewWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end

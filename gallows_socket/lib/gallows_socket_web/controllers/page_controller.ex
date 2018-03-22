defmodule GallowsSocketWeb.PageController do
  use GallowsSocketWeb, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end

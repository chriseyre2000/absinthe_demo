defmodule A1New.Schema.Mutation.CreateMenuTest do
  use A1NewWeb.ConnCase, async: true

  alias A1New.{Repo, Menu}
  import Ecto.Query

  setup do
    A1New.Seeds.run()

    category_id =
      from(t in Menu.Category, where: t.name == "Sandwiches")
      |> Repo.one()
      |> Map.fetch!(:id)
      |> to_string()

    {:ok, category_id: category_id}
  end

  @query """
  mutation ($menuItem: MenuItemInput!) {
    createMenuItem(input: $menuItem) {
      errors {key message}
      menuItem {
        name
        description
        price
      }
    }
  }
  """
  test "createMenuItem field creates an item", %{category_id: category_id} do
    menu_item = %{
      "name" => "French Dip",
      "description" => "Roast beef, caramelized onions, horseradish, ...",
      "price" => "5.75",
      "categoryId" => category_id
    }

    conn = build_conn()

    conn =
      post conn, "/api",
        query: @query,
        variables: %{"menuItem" => menu_item}

    assert json_response(conn, 200) == %{
             "data" => %{
               "createMenuItem" => %{
                 "errors" => nil,
                 "menuItem" => %{
                   "name" => menu_item["name"],
                   "description" => menu_item["description"],
                   "price" => menu_item["price"]
                 }
               }
             }
           }
  end

  test "creating a menu item with an existing name fails", %{category_id: category_id} do
    menu_item = %{
      "name" => "Reuben",
      "description" => "Roast beef, caramelized onions, horseradish...",
      "price" => "5.75",
      "categoryId" => category_id
    }

    conn = build_conn()

    conn =
      post conn, "/api",
        query: @query,
        variables: %{"menuItem" => menu_item}

    assert json_response(conn, 200) == %{
             "data" => %{
               "createMenuItem" => %{
                 "errors" => [
                   %{
                     "message" => "has already been taken",
                     "key" => "name"
                   }
                 ],
                 "menuItem" => nil
               }
             }
           }
  end
end

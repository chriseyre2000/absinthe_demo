defmodule A1NewWeb.Schema.Query.MenuItemTest do
  use A1NewWeb.ConnCase, async: true

  setup do
    A1New.Seeds.run()
  end

  @query """
    {
      menuItems {
        name
      }
    }
  """

  test "menuItems field returns menuItems" do
    conn = build_conn()
    conn = get conn, "/api", query: @query

    assert json_response(conn, 200) == %{
             "data" => %{
               "menuItems" => [
                 %{"name" => "Reuben"},
                 %{"name" => "Croque Monsieur"},
                 %{"name" => "Muffuletta"},
                 %{"name" => "Bánh mì"},
                 %{"name" => "Vada Pav"},
                 %{"name" => "French Fries"},
                 %{"name" => "Papadum"},
                 %{"name" => "Pasta Salad"},
                 %{"name" => "Water"},
                 %{"name" => "Soft Drink"},
                 %{"name" => "Lemonade"},
                 %{"name" => "Masala Chai"},
                 %{"name" => "Vanilla Milkshake"},
                 %{"name" => "Chocolate Milkshake"}
               ]
             }
           }
  end
end
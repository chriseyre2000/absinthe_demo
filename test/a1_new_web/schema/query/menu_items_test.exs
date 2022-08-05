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
                 %{"name" => "Bánh mì"},
                 %{"name" => "Chocolate Milkshake"},
                 %{"name" => "Croque Monsieur"},
                 %{"name" => "French Fries"},
                 %{"name" => "Lemonade"},
                 %{"name" => "Masala Chai"},
                 %{"name" => "Muffuletta"},
                 %{"name" => "Papadum"},
                 %{"name" => "Pasta Salad"},
                 %{"name" => "Reuben"},
                 %{"name" => "Soft Drink"},
                 %{"name" => "Vada Pav"},
                 %{"name" => "Vanilla Milkshake"},
                 %{"name" => "Water"}
               ]
             }
           }
  end

  @query """
  {
    menuItems(filter: {name: "reu"}) {
      name
    }
  }
  """
  test "menuItems field returns menu items filtered by name" do
    response = get(build_conn(), "/api", query: @query)

    assert json_response(response, 200) == %{
             "data" => %{
               "menuItems" => [
                 %{"name" => "Reuben"}
               ]
             }
           }
  end

  @query """
  {
    menuItems(filter: 123) {
      name
    }
  }
  """
  test "menuItems field returns errors when using a bad query" do
    response = get(build_conn(), "/api", query: @query)

    assert %{
             "errors" => [
               %{"message" => message}
             ]
           } = json_response(response, 200)

    assert message == "Argument \"filter\" has invalid value 123."
  end

  @query """
  query($filter: MenuItemFilter!) {
    menuItems(filter: $filter) {
      name
    }
  }
  """

  @variables %{"filter" => %{"name" => "reu"}}

  test "menuItems field returns menu items filtered by name when using a query" do
    response = get(build_conn(), "/api", query: @query, variables: @variables)

    assert json_response(response, 200) == %{
             "data" => %{
               "menuItems" => [
                 %{"name" => "Reuben"}
               ]
             }
           }
  end

  @query """
  {
    menuItems(order: DESC) {
      name
    }
  }
  """
  test "menuItems fields returns items descended using literals" do
    response = get(build_conn(), "/api", query: @query)
    assert %{
      "data" => %{"menuItems" => [%{"name" => "Water"} | _ ]}
    } = json_response(response, 200)
  end

  @query """
  query ($order: SortOrder!) {
    menuItems(order: $order) {
      name
    }
  }
  """

  @variables %{"order" => "DESC"}
  test "menuItems fields returns items descended using variables" do
    response = get(build_conn(), "/api", query: @query, variables: @variables)
    assert %{
      "data" => %{"menuItems" => [%{"name" => "Water"} | _ ]}
    } = json_response(response, 200)
  end

  @query """
  {
    menuItems(filter: {category: "Sandwiches", tag: "Vegetarian"}) {
      name
    }
  }
  """
  test "menuItems fields returns menuItems filtering with a literal" do
    response = get(build_conn(), "/api", query: @query)
    assert %{
      "data" => %{"menuItems" => [%{"name" => "Vada Pav"}]}
    } = json_response(response, 200)
  end

  @query """
  query ($filter: MenuItemFilter) {
    menuItems(filter: $filter) {
      name
      addedOn
    }
  }
  """

  @variables %{filter: %{"addedBefore" => "2017-01-20"}}
  test "minimums are filtered by a custom scalar" do
    sides = A1New.Repo.get_by!(A1New.Menu.Category, name: "Sides")
    %A1New.Menu.Item{
      name: "Garlic Fries",
      added_on: ~D[2017-01-01],
      price: 2.50,
      category: sides,
    }
    |> A1New.Repo.insert!

    response = get(build_conn(), "/api", query: @query, variables: @variables)

    assert %{
      "data" => %{
        "menuItems" => [%{"name" => "Garlic Fries", "addedOn" => "2017-01-01"}]
      }
    } == json_response(response, 200)
  end
end

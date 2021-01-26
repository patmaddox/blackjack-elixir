defmodule Blackjack.PlayerTest do
  use ExUnit.Case
  alias Blackjack.Player

  describe "new" do
    test "has a name, cash, and 0 chips" do
      player = Player.new("Pat", 100)
      assert player == %Player{name: "Pat", cash: 100, chips: 0}
    end
  end

  describe "buy_chips" do
    test "converts cash to chips" do
      player =
        Player.new("Pat", 100)
        |> Player.buy_chips(75)

      assert player == %Player{name: "Pat", cash: 25, chips: 75}
    end

    test "can happen more than once" do
      player =
        Player.new("Pat", 100)
        |> Player.buy_chips(25)
        |> Player.buy_chips(25)

      assert player == %Player{name: "Pat", cash: 50, chips: 50}
    end

    test "doesn't let you overspend" do
      {:error, message} =
        Player.new("Pat", 100)
        |> Player.buy_chips(101)

      assert message == "Not enough cash"
    end
  end

  describe "cash_out" do
    test "converts chips to cash" do
      player =
        Player.new("Pat", 100)
        |> Player.buy_chips(75)
        |> Player.cash_out(10)

      assert player == %Player{name: "Pat", cash: 35, chips: 65}
    end

    test "can happen more than once" do
      player =
        Player.new("Pat", 100)
        |> Player.buy_chips(75)
        |> Player.cash_out(10)
        |> Player.cash_out(15)

      assert player == %Player{name: "Pat", cash: 50, chips: 50}
    end

    test "doesn't let you cash out more than you have" do
      {:error, message} =
        Player.new("Pat", 100)
        |> Player.buy_chips(100)
        |> Player.cash_out(101)

      assert message == "Not enough chips"
    end
  end

  test "pipe the things" do
    {:error, message} =
      Player.new("Pat", 100)
      |> Player.buy_chips(100)
      |> Player.cash_out(101)
      |> Player.buy_chips(101)

    assert message == "Not enough chips"
  end
end

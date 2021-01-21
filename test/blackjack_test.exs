defmodule BlackjackTest do
  use ExUnit.Case
  doctest Blackjack

  describe "new_player" do
    test "has a name, cash, and 0 chips" do
      player = Blackjack.new_player("Pat", 100)
      assert player == %Blackjack.Player{name: "Pat", cash: 100, chips: 0}
    end
  end

  describe "buy_chips" do
    test "converts cash to chips" do
      player =
        Blackjack.new_player("Pat", 100)
        |> Blackjack.buy_chips(75)

      assert player == %Blackjack.Player{name: "Pat", cash: 25, chips: 75}
    end

    test "can happen more than once" do
      player =
        Blackjack.new_player("Pat", 100)
        |> Blackjack.buy_chips(25)
        |> Blackjack.buy_chips(25)

      assert player == %Blackjack.Player{name: "Pat", cash: 50, chips: 50}
    end

    test "doesn't let you overspend" do
      {:error, message} =
        Blackjack.new_player("Pat", 100)
        |> Blackjack.buy_chips(101)

      assert message == "Not enough cash"
    end
  end
end

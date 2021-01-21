defmodule Blackjack do
  alias Blackjack.Player

  def new_player(name, cash) do
    Player.new(name, cash)
  end

  def buy_chips(player, amount) do
    Player.buy_chips(player, amount)
  end

  def cash_out(player, amount) do
    Player.cash_out(player, amount)
  end
end

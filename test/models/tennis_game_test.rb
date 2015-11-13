require 'test_helper'

class TennisGameTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  test "score starts as love-love" do
    game = TennisGame.new("Mike", "Dave")
    assert_equal("love-love", game.score)
  end

  test "score goes to 15-love when a player scores" do
    game = TennisGame.new("Mike", "Dave")
    game.won_point("Mike")
    assert_equal("15-love", game.score)
  end

  test "score goes to 15-15 when second player scores" do
    game = TennisGame.new("Mike", "Dave")
    game.won_point("Mike")
    game.won_point("Dave")
    assert_equal("15-15", game.score)
  end

  test "score goes to 30-15 when first player scores agains" do
    game = TennisGame.new("Mike", "Dave")
    game.won_point("Mike")
    game.won_point("Dave")
    game.won_point("Mike")
    assert_equal("30-15", game.score)
  end

  test "score goes to 40-15 when first player scores again" do
    game = TennisGame.new("Mike", "Dave")
    game.won_point("Mike")
    game.won_point("Dave")
    game.won_point("Mike")
    game.won_point("Mike")
    assert_equal("40-15", game.score)
  end

  test "score goes to 40-30 when first player scores again" do
    game = TennisGame.new("Mike", "Dave")
    3.times { game.won_point('Mike') }
    2.times { game.won_point('Dave') }
    assert_equal("40-30", game.score)
  end

  test "first player wins game if he gets to 4 points and second player only has 2 or fewer" do
    game = TennisGame.new("Mike", "Dave")
    4.times { game.won_point('Mike') }
    2.times { game.won_point('Dave') }
    assert_equal("Mike defeats Dave", game.score)
  end

  test "second player wins game if he gets to 4 points and first player only has 2 or fewer" do
    game = TennisGame.new("Mike", "Dave")
    2.times { game.won_point('Mike') }
    4.times { game.won_point('Dave') }
    assert_equal("Dave defeats Mike", game.score)
  end

  test "both players have 3 points, score is deuce" do
    game = TennisGame.new("Mike", "Dave")
    3.times { game.won_point('Mike') }
    3.times { game.won_point('Dave') }
    assert_equal("Deuce", game.score)
  end

  test "first player gets to 3 points, second player to 3 points, then first player scores, score is 'Advantage In'" do
    game = TennisGame.new("Mike", "Dave")
    3.times { game.won_point('Mike') }
    3.times { game.won_point('Dave') }
    game.won_point('Mike')
    assert_equal('Advantage In', game.score)
  end

  test "first player gets to 3 points, second player to 3 points, then second player scores, score is 'Advantage Out'" do
    game = TennisGame.new("Mike", "Dave")
    3.times { game.won_point('Mike') }
    3.times { game.won_point('Dave') }
    game.won_point('Dave')
    assert_equal('Advantage Out', game.score)
  end

  test "first player gets 3 points, second player 2 points, then first player 2 points, first player wins" do
    game = TennisGame.new("Mike", "Dave")
    3.times { game.won_point('Mike') }
    3.times { game.won_point('Dave') }
    2.times { game.won_point('Mike') }
    assert_equal('Mike defeats Dave', game.score)
  end
  test "first player gets 3 points, second player 5 points, second player wins" do
    game = TennisGame.new("Mike", "Dave")
    3.times { game.won_point('Mike') }
    5.times { game.won_point('Dave') }
    assert_equal('Dave defeats Mike', game.score)
  end

  # This last test is to double-check that as the score increase by 1 (like a real tennis match) the code doesn't break
  test "players alternate scores, up to 5 points, before player 1 breaks away and wins two straight points" do
    game = TennisGame.new("Mike", "Dave")
    2.times { game.won_point('Mike') }
    2.times { game.won_point('Dave') }
    assert_equal('30-30', game.score)
    game.won_point('Mike')
    assert_equal('40-30', game.score)
    game.won_point('Dave')
    assert_equal('Deuce', game.score)
    game.won_point('Mike')
    assert_equal('Advantage In', game.score)
    game.won_point('Dave')
    assert_equal('Deuce', game.score)
    2.times { game.won_point('Mike') }
    assert_equal('Mike defeats Dave', game.score)
  end
end

require_relative 'mastermind.rb'
require 'sinatra'
require 'sinatra/reloader'

class Counter
  attr_accessor :count
  def initialize
    @count = 0
  end

  def up
    @count += 1
  end
end

def table(turn, guess, result)
  return "<tr><td>#{turn}</td><td>#{guess}</td><td>#{result}</td></tr>"
end

a_game = Game.new
count = Counter.new
score = ''

get '/' do
  # throw a_game.win.inspect
  turn = count.count
  count.up if turn == 0
  turn = 1 if turn == 0
  count = Counter.new if turn > 10 || a_game.win == true
  a_game = Game.new if turn > 10 || a_game.win == true
  score = '' if turn > 10 || a_game.win == true
  count.up
  guess = params['color_guess']
  index_form_guess = color_to_index(guess.to_s)
  result = a_game.guessing(a_game.picks, index_form_guess, turn)
  score = score + table(turn, guess, result)
  erb :index, :locals => {:a_game => a_game, :guess => guess, :result => result, :turn => turn, :score => score}
end



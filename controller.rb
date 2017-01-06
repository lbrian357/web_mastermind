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
  turn = count.count
  guess = params['color_guess']
  index_form_guess = color_to_index(guess.to_s)
  result = a_game.guessing(a_game.picks, index_form_guess, turn)


  score = score + table(turn, guess, result) if turn > 0 && turn < 11#draws another row in score table with guess and clues/results
  
  if params['play_again'] == 'yes'
    count = Counter.new 
    a_game = Game.new 
    score = '' 
  end

  count.up
  
  erb :index, :locals => {:a_game => a_game, :guess => guess, :result => result, :turn => turn, :score => score}
end



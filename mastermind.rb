def c_code
  colors = ['red','green','blue','yellow','brown','orange','black','white']
  c = {}
  colors.each {|i| c[(colors.index(i))] = i}
  c
end

def pick
  picks = []
  4.times {picks << rand(0...8)}
  picks
end

def color_to_index(string)
  array = string.split(' ')
  array.map { |i| c_code.invert[i] }
end

def index_to_color(array)
  a = []
  array.each { |i| a << c_code[i] }
  a.join(' ')
end

class Game
  attr_accessor :picks, :win
  def initialize
    #@picks = pick 
    @picks = [0, 0, 1, 1] #for testing purposes
    @win = false
  end

  def start
    return "Enter any of the following colors: #{c_code.values.join(', ')}"
    return "a 'O' signifies a correct color but an incorrect position, while a '@' signifies a correct color with the correct position as well"
    return "you have 10 turns"
    human_guess
  end

  def human_guess
    #get user input on their guess
    for i in 1..10 do 
      if win == true
        break
      end

      return "\nturn number #{i}"
      return "please enter your guess separated by a space: "
      str_guess = gets.chomp 
      guess = color_to_index(str_guess) #turns user colors into corresponding color code number
      guessing(picks,guess, i) #pass guess in color code to guessing function
    end
    return 'END'
  end

  def guessing(picks, guess, i) #compares answer with guess and outputs clue
    if guess == picks
      @win = true #find out WHY attr_accessor is not enough to change win = true to @win = true

      #return index_to_color(guess)
      return 'Correct! You Win!'
    elsif i > 10
      return "WRONG! You Lose!
              \nthe answer was #{index_to_color(picks)}"
    else
      #check if user guess is included in answer
      #puts index_to_color(guess)
      #p guess

      correct_colors = []

      picks.uniq.each do |i| #loop computes number of correct colors
        if picks.count(i) <= guess.count(i) 
          picks.count(i).times {correct_colors << 'O'}
        else
          guess.count(i).times {correct_colors << 'O'}
        end
      end
      for i in 0...4 do #loop computes number of correct positions
        if picks[i] == guess[i]
          correct_colors << '@'
          correct_colors.shift
        end
      end
      return correct_colors.join if win != true && i != 10 #return clues
      end
  end

  #print out clues if guesses were in answer
  #O for right color but wrong position
  #and @ for right color and right position
  #it should print how many chances are left and keep history of guesses
  #when guess == picks and guesses_left > 0 you win


end

#a = Game.new
#a.start


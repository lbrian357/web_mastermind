module Generator
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
end

class Game
  include Generator
  attr_accessor :picks, :win
  def initialize
    #@picks = pick 
    @picks = [0, 0, 1, 1] #for testing purposes
    @win = false
  end

  def start
    puts 'would you like to solve my mastermind puzzle or would you like me to solve yours? Enter \'solve\' or \'pose\''
    play_decision = gets.chomp
    if play_decision == 'solve'
      puts "Enter any of the following colors: #{c_code.values.join(', ')}"
      puts "a 'O' signifies a correct color but an incorrect position, while a '@' signifies a correct color with the correct position as well"
      puts "you have 10 turns"
      human_guess
    elsif play_decision == 'pose'
      human_picks
      comp_guess
    else
      puts 'I do not understand, please enter a valid response'
      start
    end
  end

  def human_picks
    puts 'give me an four colors to crack human: '
    h_p = gets.chomp
    self.picks = color_to_index(h_p)
  end

  def comp_guess
    keep = []
    for i in 1..12
      if win == true
        break
      end

      
      comp_guess = pick
      keep.uniq.each do |k|
        comp_guess.insert(rand(0..3), keep[k]).pop
      end

     guessing(comp_guess, i)

      comp_guess.each do |j|
        if picks.include?(j)
          keep << j
        end
      end

 
    end
  end 

  def human_guess
    #get user input on their guess
    for i in 1..10 do 
      if win == true
        break
      end

      print "\n please enter your guess separated by a space: "
      str_guess = gets.chomp 
      guess = color_to_index(str_guess) #turns user colors into corresponding color code number
      guessing(guess, i) #gives color code to guessing function
    end
    puts 'END'
  end

  def guessing(guess, i)
    puts "\n turn number #{i}"
    if guess == picks
      self.win = true #find out WHY THE FUCK is attr_accessor not enough to change win = true to @win = true
      
      puts index_to_color(guess)
      puts 'You Win!'
    elsif i == 10
      puts 'WRONG! You Lose!'
      puts "the answer was #{index_to_color(picks)}"
      

    else
      #check if user guess is included in answer
      p index_to_color(guess)
      #p guess
      correct_colors = []
      picks.uniq.each do |i|
        if picks.count(i) <= guess.count(i) 
          picks.count(i).times {correct_colors << 'O'}
        else
          guess.count(i).times {correct_colors << 'O'}
        end
      end
      #guess.uniq.each do |i|
      #  picks.count(i).times {print 'O'}
      #end
      #guess.each { |i| print 'O' if picks.include?(i)}
      for i in 0...4 do
        if picks[i] == guess[i]
          correct_colors << '@'
          correct_colors.shift
        end
      end
    end
    puts correct_colors.join if win != true
  end

  #print out clues if guesses were in answer
  #O for right color but wrong position
  #and @ for right color and right position
  #it should print how many chances are left and keep history of guesses

  #when guess == picks and guesses_left > 0 you win


end

a = Game.new
a.start


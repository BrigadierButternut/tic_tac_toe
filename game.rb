class Game

  attr_accessor :endGame, :container

  GRIDVALUES = {1 => 0, 2 => 2, 3 => 4}

def initialize
  # The first row.
  row1 = []
  row1.push(" ")
  row1.push("|")
  row1.push(" ")
  row1.push("|")
  row1.push(" ")

  dashes1 = []
  dashes1.push("--")
  dashes1.push("--")
  dashes1.push("--")
  dashes1.push("--")
  dashes1.push("-")


  # The second row.
  row2 = []
  row2.push(" ")
  row2.push("|")
  row2.push(" ")
  row2.push("|")
  row2.push(" ")

  dashes2 = []
  dashes2.push("--")
  dashes2.push("--")
  dashes2.push("--")
  dashes2.push("--")
  dashes2.push("-")

  #third row
  row3 = []
  row3.push(" ")
  row3.push("|")
  row3.push(" ")
  row3.push("|")
  row3.push(" ")

  # The 2D array (a container of the other arrays).
  @container = []
  @container.push(row1)
  @container.push(dashes1)
  @container.push(row2)
  @container.push(dashes2)
  @container.push(row3)
end

def displayBoard
  @container.each_with_index do |arr,index|
    if index%2==0
      arr.each do |inner|
          print inner + " "
      end
    else
      arr.each do |inner|
        print inner
      end
    end
      print "\n"
  end
end


def winner?
  winConditions = []
  winConditions.push([@container[0][0],@container[2][2],@container[0][4]]) #top left to bottom right
  winConditions.push([@container[0][4],@container[2][2],@container[4][4]]) #top right to bottom left
  winConditions.push([@container[0][0],@container[0][2],@container[0][4]]) #top row
  winConditions.push([@container[2][0],@container[2][2],@container[2][4]]) #middle row
  winConditions.push([@container[4][0],@container[4][2],@container[4][4]]) #bottom row
  winConditions.push([@container[0][0],@container[2][0],@container[4][0]]) #first column
  winConditions.push([@container[0][2],@container[2][2],@container[4][2]]) #second column
  winConditions.push([@container[0][4],@container[2][4],@container[4][4]]) #third column

  winsMet = []
  winConditions.each do |array|
    winsMet.push(array.all? {|element| element == array.first && element != " "})
  end

  winsMet.any? {|wins| wins == true}
end


def stalemate?
  blackout = []
  GRIDVALUES.each_pair do |key,value|
    blackout.push(!@container[value].include?(" "))
  end
  blackout.all? {|element| element == true}
end


def checkProgress
  @endGame = false
  if winner? == true
    puts "We have a winner!"
    @endGame = true
  elsif stalemate? == true
    puts "Stalemate!"
    @endGame = true
  end
end

def playerMove(playerNum)

  puts "Player #{playerNum} turn"
  userMove = gets.scan(/\d/).map! {|element| element.to_i}
  x = userMove[0]
  y = userMove[1]
  if @container[GRIDVALUES[x]][GRIDVALUES[y]] != " "
    puts "That tile is already marked. Please place marker in different location"
    self.playerMove(playerNum)
  else
    if playerNum == 1
      @container[GRIDVALUES[x]][GRIDVALUES[y]] = "X"
    else
      @container[GRIDVALUES[x]][GRIDVALUES[y]] = "O"
    end
  end
  self.displayBoard
  self.checkProgress
end #end of playerMove definition



end #end of Game definition



def ticTacToe
  puts "TIC TAC TOE"
  players = [1,2]
  game = Game.new
  game.displayBoard
  puts "Player 1 = X, Player 2 = O"
  puts "To place your mark, input \'(x,y)\' on your turn"
  until game.endGame do
  players.each do |playerNum|
    game.playerMove(playerNum)
    break if game.endGame
  end
end

end #end of ticTacToe definition

ticTacToe

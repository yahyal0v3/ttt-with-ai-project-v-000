require 'pry'

module Players
  class Computer < Player

    WIN_COMBINATIONS = [
     ["1","2","3"],
     ["4","5","6"],
     ["7","8","9"],
     ["1","4","7"],
     ["2","5","8"],
     ["3","6","9"],
     ["1","5","9"],
     ["3","5","7"]
     ]

    def move(board)
      binding.pry
      board.cells = ["X", "O", "X", "", "O", " ", " ", "X", " "]
      corners = ["1", "3", "7", "9"]
      opponents_almost_win = nil

      WIN_COMBINATIONS.each do |win_combination|
        if self.token == "X"
          opponents_positions = win_combination.select {|position| board.position(position) == "O"}
          opponents_almost_win = opponents_positions if opponents_positions.length == 2
        elsif self.token == "O"
          opponents_positions = win_combination.select {|position| board.position(position) == "X"}
          opponents_almost_win = opponents_positions if opponents_positions.length == 2
        end
      end
      
      move = nil
      WIN_COMBINATIONS.each do |win_combination|
        missing_position = win_combination - opponents_almost_win
        move = missing_position if missing_position.size == 1
      end 

      if board.taken?("5") == false
        "5"
      elsif opponents_almost_win != nil && board.taken?(move.join) == false
        move.join
      elsif corners.any? {|position| board.taken?(position) == false}
        corners.sample
      else
          ["1", "2", "3", "4", "5", "6", "7", "8", "9"].sample
      end
    end
  end
end

class TicTacToe
   
   WIN_COMBINATIONS = [ 
    [0,1,2], # top_row 
    [3,4,5], # middle_row 
    [6,7,8], # bottom_row 
    [0,3,6], # left_column 
    [1,4,7], # center_column 
    [2,5,8], # right_column 
    [0,4,8], # left_diagonal 
    [6,4,2] # right_diagonal 
    ]

    def initialize(board = nil)
      @board = board || Array.new(9, " ")
    end
  
    def current_player
      turn_count % 2 == 0 ? "X" : "O"
    end
  
    def turn_count
      @board.count{|token| token == "X" || token == "O"}
    end
  
    def display_board
      puts " #{@board[0]} | #{@board[1]} | #{@board[2]} "
      puts "-----------"
      puts " #{@board[3]} | #{@board[4]} | #{@board[5]} "
      puts "-----------"
      puts " #{@board[6]} | #{@board[7]} | #{@board[8]} "
    end

    def input_to_index(board_position)
        user_input = board_position.to_i
        user_input - 1
    end

    def move(board_index, player_token)
        @board[board_index] = player_token
    end

    def position_taken?(board_position)
        if @board[board_position] == " " 
            return false
        else
            return true
        end
    end

    def valid_move?(board_position)
        if board_position >= 0 && board_position <= 8
            if @board[board_position] == " "
                true
            end
        else
            false
        end
    end

    def turn
        puts "Select your move (1-9)\n"
        move = gets.chomp
        move_index = input_to_index(move)
        if valid_move?(move_index)
            token = current_player
            move(move_index, token)
        else
            turn
        end
        display_board
    end

    def won?
        WIN_COMBINATIONS.find do |indices|
        values = @board.values_at(*indices)
            if values.all?("X") || values.all?("O")
                values
            else
                false
            end
        end  
    end

    def full?
        @board.all?{|index| index != " "}
    end

    def draw?
       !won? && full?
    end

    def over?
        won? || draw?
    end

    def winner
        combo = won?
        if combo
            if combo.all? {|i| @board[i] == "X"}
            "X"
            elsif combo.all? {|i| @board[i] == "O"}
             "O"
            end
        end
    end

    def play
        while !over?
            turn
        end
        if won?
            puts "Congratulations #{winner}!"
        else
            puts "Cat's Game!"
        end
    end
end 

  
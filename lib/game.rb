require_relative 'board.rb'
require_relative 'player.rb'

class Game
    attr_accessor :player1, :player2, :current_player
    attr_accessor :board
    attr_accessor :tokens

    def initialize
        @tokens = ['🟢', '🔴']
        @board = Board.new
    end

    def prepare
        welcome_message
        @player1 = create_player(1)
        @player2 = create_player(2)
        @current_player = @player2
    end

    def play 
        prepare

        until @board.game_over
            @current_player = switch_player
            play_turn
        end
    end

    def switch_player
        @current_player == @player1 ? @player2 : @player1
    end

    def play_turn
        turn_message
        move = correct_move
        @board.draw
        if @board.check_win(@current_player.symbol) 
            win_message(@current_player.name)
            @board.game_over = true
        end
    end

    def welcome_message
        puts "Welcome to Connect Four. Let's begin!"
    end

    def turn_message
        puts "#{@current_player.name} make your move:"
    end

    def correct_move
        loop do 
            move = gets.chomp.to_i
            return move if valid_move?(move)
            puts "Invalid input, select an empty column between 1 and 7."
        end
    end

    def valid_move?(move)
        move.is_a?(Integer) && move.between?(1,7) && @board.put_token(move, @current_player.symbol)
    end

    def create_player(num)
        puts "Player #{num}, please enter your name:"
        name = gets.chomp
        token = @tokens[num-1]
        Player.new(name, token)
    end

    def win_message(player_name)
        puts "Hooray, #{player_name} wins!"
    end
end

game = Game.new
game.play

require_relative 'color_token.rb'

class Board
    attr_accessor :board_rows
    attr_accessor :board_columns
    attr_accessor :board

    def initialize
        @grid_rows = 6
        @grid_columns = 7
        create  
        draw  
    end

    def create
        @grid = Array.new(@grid_rows){ Array.new(@grid_columns) { ColorToken.new } }
    end

    def draw
       @grid_rows.times do | row |
            @grid_columns.times do | column |
                print "#{@grid[row][column].color} "
            end
            2.times { puts "\n" }
        end
    end

    def check_horizontal(row, column, color)
        return if column > @grid_columns - column

        return @grid[row][column].color == color && @grid[row][column+1].color == color && 
            @grid[row][column+2].color == color && @grid[row][column+2] == color
    end

    def check_vertical(row, column, color)
        return if row > @grid_rows - row

        return @grid[row][column].color == color && @grid[row+1][column].color == color && 
            @grid[row+2][column].color == color && @grid[row+2][column].color == color
    end

    def check_left_diagonal(row, column, color) 
        return if column > @grid_columns - column

        return @grid[row][column].color == color && @grid[row+1][column+1].color == color &&
            @grid[row+2][column+2].color == color && @grid[row+3][column+3].color == color
    end

    def check_right_diagonal(row, column, color)
        return if column < @grid_columns - column

        return @grid[row][column].color == color && @grid[row+1][column-1].color == color &&
            @grid[row+2][column-2].color == color && @grid[row+3][column-3].color == color
    end

    def check_diagonals(row, column, color)
        return unless row < @grid_rows - row

        check_right_diagonal(row, column, color) || check_left_diagonal(row, column, color)
    end

    def check_win(row, column, color) 
        return check_horizontal(row, column, color) || check_vertical(row, column, color) || check_diagonals(row, column, color)
    end

    def find_free_row(row, column, color)
        @grid_rows.times do | current_row |
            return current_row if @grid[current_row][column].color == :empty 
        end
        return -1
    end
end

board = Board.new
puts board.find_free_row(3,3,:empty)
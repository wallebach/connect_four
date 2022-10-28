class Board
    attr_accessor :board_rows, :board_columns, :grid
    attr_accessor :number_of_turns, :game_over

    def initialize
        @grid_rows = 6
        @grid_columns = 7
        @moves_made = 0
        @number_of_turns = 0
        @game_over = false

        create  
    end

    def create
        @grid = Array.new(@grid_rows){ Array.new(@grid_columns) { '⚪️' } }
    end

    def draw
       @grid_rows.times do | row |
            @grid_columns.times do | column |
                print "#{@grid[row][column]} "
            end
            2.times { puts "\n" }
        end
    end

    def check_horizontal(row, column, color)
        return false if column > @grid_columns - column

        return @grid[row][column] == color && @grid[row][column+1] == color && 
            @grid[row][column+2] == color && @grid[row][column+3] == color
    end

    def check_vertical(row, column, color)
        return false if row >= @grid_rows - row

        return @grid[row][column] == color && @grid[row+1][column] == color && 
            @grid[row+2][column] == color && @grid[row+3][column] == color
    end

    def check_left_diagonal(row, column, color) 
        return false if column > @grid_columns - column

        return @grid[row][column] == color && @grid[row+1][column+1] == color &&
            @grid[row+2][column+2] == color && @grid[row+3][column+3] == color
    end

    def check_right_diagonal(row, column, color)
        return false if column < @grid_columns - column

        return @grid[row][column] == color && @grid[row+1][column-1] == color &&
            @grid[row+2][column-2] == color && @grid[row+3][column-3] == color
    end

    def check_diagonals(row, column, color)
        return unless row < @grid_rows - row

        check_right_diagonal(row, column, color) || check_left_diagonal(row, column, color)
    end

    def check_win(color) 
        @grid_rows.times do | row |
            @grid_columns.times do | column |
                if check_horizontal(row, column, color) || check_vertical(row, column, color) || check_diagonals(row, column, color)
                    puts "eaaaa"
                    return true
                end
            end
        end
        return false
    end

    def put_token(column, color)
        can_put = false
        rows_num = @grid_rows - 1
        rows_num.downto(0) do | current_row |
            if @grid[current_row][column] == '⚪️'
                @grid[current_row][column] = color
                increase_moves_num
                can_put = true
                return can_put
            end
        end

        can_put
    end

    def increase_moves_num
        @moves_made += 1
        if @moves_made == @grid_rows * @grid_columns
            @game_over = true
        end
    end
end

board = Board.new
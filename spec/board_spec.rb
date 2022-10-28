require_relative '../lib/board.rb'
require_relative '../lib/game.rb'

describe Board do
    subject(:board) { described_class.new } 

    describe '#place_token' do 
        context "when column is empty" do
            it "puts the token to the bottom" do
                board.put_token(0, ColorToken.player1_color)
                expect(board.grid[5][0].color).to eq(ColorToken.player1_color)
            end
        end

        context "when column has 2 bottom slots filled" do
            it "put the token into the third position from the bottom" do
                board.put_token(0, ColorToken.player1_color)
                board.put_token(0, ColorToken.player1_color)
                board.put_token(0, ColorToken.player2_color)
                expect(board.grid[3][0].color).to eq(ColorToken.player2_color)
            end
        end

        context "when the column is full" do 
            it "don't put any token into the full column" do 
                6.times do 
                    board.put_token(1, ColorToken.player2_color)
                end 
                expect(board.put_token(1, ColorToken.player2_color)).to eq(false)
            end
        end

    end
    
end

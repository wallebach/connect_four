require_relative '../lib/board.rb'

describe Board do
    subject(:board) { described_class.new } 

    describe '#place_token' do 
        context "when column is empty" do
            it "puts the token to the bottom" do
                board.put_token(0, '🔴')
                expect(board.grid[5][0]).to eq('🔴')
            end
        end

        context "when column has 2 bottom slots filled" do
            it "put the token into the third position from the bottom" do
                board.put_token(0, '🔴')
                board.put_token(0, '🔴')
                board.put_token(0, '🔴')
                expect(board.grid[3][0]).to eq('🔴')
            end
        end

        context "when the column is full" do 
            it "don't put any token into the full column" do 
                6.times do 
                    board.put_token(1, '🟢')
                end 
                expect(board.put_token(1, '🟢')).to eq(false)
            end
        end

        context "when board is full" do 
            before do
                board.instance_variable_set(:@game_over, true)
            end

            it "then it's not possible to put a token" do 
                expect(board.game_over).to be true
            end
        end

        context "when there is a win vertically" do 
            before do
                board.instance_variable_set(:@grid,
                [['⚪️','⚪️','⚪️','⚪️','⚪️','⚪️','⚪️'],
                 ['⚪️','⚪️','⚪️','⚪️','🟢','⚪️','⚪️'],
                 ['⚪️','⚪️','⚪️','⚪️','🟢','⚪️','⚪️'],
                 ['⚪️','⚪️','⚪️','⚪️','🟢','⚪️','⚪️'],
                 ['⚪️','⚪️','⚪️','⚪️','🟢','⚪️','⚪️'],
                 ['⚪️','⚪️','⚪️','⚪️','🔴','⚪️','⚪️']])
            end

            it "means win of player #1" do 
                expect(board.check_win('🟢')).to be true
            end
        end

        context "when there is a win horizontally" do 
            before do
                board.instance_variable_set(:@grid,
                [['⚪️','⚪️','⚪️','⚪️','⚪️','⚪️','⚪️'],
                 ['⚪️','⚪️','⚪️','⚪️','⚪️','⚪️','⚪️'],
                 ['⚪️','⚪️','⚪️','⚪️','⚪️','⚪️','⚪️'],
                 ['⚪️','⚪️','⚪️','⚪️','⚪️','⚪️','⚪️'],
                 ['⚪️','🔴','🔴','🔴','🔴','⚪️','⚪️'],
                 ['⚪️','🔴','🟢','🟢','🟢','⚪️','⚪️']])
            end

            it "means win of player #2" do 
                expect(board.check_win('🔴')).to be true
            end
        end

        context "when there is a win in diagonal" do 
            before do
                board.instance_variable_set(:@grid,
                [['⚪️','⚪️','⚪️','⚪️','⚪️','⚪️','⚪️'],
                 ['⚪️','⚪️','⚪️','⚪️','⚪️','⚪️','⚪️'],
                 ['⚪️','⚪️','⚪️','🟢','⚪️','⚪️','⚪️'],
                 ['⚪️','⚪️','⚪️','🔴','🟢','⚪️','⚪️'],
                 ['⚪️','🔴','🔴','🔴','🔴','🟢','⚪️'],
                 ['⚪️','🔴','🟢','🟢','🟢','⚪️','🟢']])
            end

            it "means win of player #1" do 
                expect(board.check_win('🟢')).to be true
            end
        end

    end
    
end

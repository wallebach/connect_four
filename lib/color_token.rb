class ColorToken
    attr_accessor :color

    @@empty_color = '⚪️'
    @@player1_color = '🔴'
    @@player2_color = '🟢'

    def initialize(color = @@empty_color)
        @color = color
    end

    def self.empty_color
        return @@empty_color 
    end

    def self.player1_color
        return @@player1_color
    end

    def self.player2_color
        return @@player2_color
    end
end
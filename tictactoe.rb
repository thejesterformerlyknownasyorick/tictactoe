module Game
    def game_loop
        puts "Player 1, please enter your name: "
        name = gets.chomp
        puts "What symbol would you like to represent you?"
    symbol = gets.chomp
    player1 = GameTools.new(name, symbol)

    puts "Player 2, please enter your name: "
    name = gets.chomp
    puts "What symbol would you like to represent you?"
    symbol = gets.chomp
    player2 = GameTools.new(name, symbol)

    if player1.symbol == player2.symbol
        puts "Oh, y'all wanna player with the same symbol? That's fine, I can track it. Can you?"
    end

    game_grid = GameTools.new("tictactoe", "#")
        i = 0
        player = 1
        while i < 9
            if player == 1
                game_grid.grid_arr
                player1.player_choice = gets.chomp.to_i
                if player2.array.any? { |x| x == player1.player_choice }
                    puts "Wow, trying to move in on their territory? You forfeit your turn."
                else 
                    player1.player_array_creator
                    player1.change_game_board
                    player1.win_check ? i = 9 : i += 1
                end
                player += 1
            else
                game_grid.grid_arr
                player2.player_choice = gets.chomp.to_i
                if player1.array.any? { |x| x == player2.player_choice }
                    puts "Wow, trying to move in on their territory? You forfeit your turn."
                else
                    player2.player_array_creator
                    player2.change_game_board
                    player2.win_check ? i = 9 : i += 1
                end
                player -= 1
            end
        end
        if player1.win_check == true
            puts "Congrats #{player1.name}! You're good at a game that's too elementary for first graders."
        elsif player2.win_check == true
            puts "Wow #{player2.name}, do you know how hard it is to win Tic-Tac-Toe if you go second? #{player1.name} must be really dumb."
        else
            puts "A tie? That's boring. Just like Tic-Tac-Toe."
        end
    end
end

module VictoryCheck
    
    def check(win_array, p)
        perm_array = p.permutation(3) {|permutation| p += permutation}
        win_array.any? { |arr| 
        arr == perm_array
        }
    end

end

module PlayerArray
    
    def add_to_array(player_arr, x)
        player_arr.push(x)
    end

end

module GridCreator
    def grid(arr)
        puts " #{arr[0]} | #{arr[1]} | #{arr[2]} "
        puts "------------"
        puts " #{arr[3]} | #{arr[4]} | #{arr[5]} " 
        puts "------------"
        puts " #{arr[6]} | #{arr[7]} | #{arr[8]} "
        puts "\nWhich space would you like to occupy?"
    end
end

module GridChanger
    def replace(array, index, symbol)
        array[index - 1] = symbol
    end
end

class GameTools

    include GridCreator
    include VictoryCheck
    include PlayerArray
    include GridChanger
    include Game

    attr_reader :name, :symbol
    attr_accessor :array, :player_choice

    @@i = [1,2,3,4,5,6,7,8,9]
    @@v = [[1,2,3], [4,5,6], [7,8,9], [1,4,7], [2,5,8], [3,6,9], [1,5,9], [3,5,7]]

    class << self
        attr_accessor :i, :v
    end
   
    def initialize (name, symbol)
        @name = name
        @symbol = symbol
        @array = Array.new()
        @player_choice = ""
    end

    def player_array_creator
        add_to_array(@array, @player_choice)
    end

    def grid_arr
        grid(@@i)
    end

    def win_check
        check(@@v, @array)
    end

    def change_game_board
        replace(@@i, @player_choice, @symbol)
    end

    def gameplay
        game_loop
    end
end

tictactoe = GameTools.new("game", 7)

tictactoe.gameplay
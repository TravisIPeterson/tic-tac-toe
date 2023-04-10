require "pry-byebug"
module Game

    def game_begin()
        puts "Hello, player 1! What is your name?"
        player1_name = gets.chomp
        puts "And what symbol would you like?"
        player1_symbol = gets.chomp
        until player1_symbol.length == 1
            puts "How about we just stick with a single character? Otherwise the grid will get all screwed up."
            player1_symbol = gets.chomp
        end
        puts "Now player 2! What is your name?"
        player2_name = gets.chomp
        puts "And what symbol would you like?"
        player2_symbol = gets.chomp
        until player2_symbol.length == 1
            puts "How about we just stick with a single character? Otherwise the grid will get all screwed up."
            player2_symbol = gets.chomp
        end
        if player1_symbol == player2_symbol
            "Oh, you want to play with the same symbols? I can keep track of who's who. Can you?"
        end
        @player1 = Player.new(player1_name, player1_symbol)
        @player2 = Player.new(player2_name, player2_symbol)
        gameloop()
    end

    def gameloop()
        turn = 0
        @current_player = @player1
        other_player = @player2
        @game = GameTools.new
        while turn < 9
            @game.grid_display
            puts "\n#{@current_player.name}, which space would you like to claim?"
            @current_player.player_choice = gets.chomp.to_i
            if other_player.array.any? { |x| x == @current_player.player_choice }
                puts "Wow, trying to move in on your opponents territory? You forfeit your turn."
            else
                @current_player.player_array_update
                @current_player.grid_update
            end
            if @current_player.win_check == true
                puts "You won a game people outgrow by the age of 5. Congrats? Now shame your opponent."
                turn = 10
            elsif @current_player == @player1
                @current_player = @player2
                other_player = @player1
            elsif @current_player == @player2
                @current_player = @player1    
                other_player = @player2
            else
                puts "Something went wrong."
            end
            turn += 1
        end
        game_end()
    end
    
    def game_end()
        if @player1.win_check == false && @player2.win_check == false
            puts "You tied?!?! In Tic-Tac-Toe?!?!?! How can it be? Oh well, bye."
        elsif @player1.win_check == true
            puts "#{@player1.name} wins....a game most people outgrow at age 5. Congrats I guess?"
        elsif @player2.win_check == true
            puts "#{@player2.name} wins! Do you know how hard it is to win Tic-Tac-Toe if you go second? #{player1.name}, you should be really embarrassed."
        else
            puts "Something went wrong."
        end
    end


end

module GridCreator

    def grid(array)
        puts " #{array[0]} | #{array[1]} | #{array[2]}"
        puts " ---------"
        puts " #{array[3]} | #{array[4]} | #{array[5]}"
        puts " ---------"
        puts " #{array[6]} | #{array[7]} | #{array[8]}"
    end

end

module GridUpdate

    def replace(array, index, symbol)
        array[index - 1] = symbol
    end

end

module AddToPlayerArray

    def add_to_array(player_array, x)
        player_array.push(x)
    end

end

module VictoryCheck

    def is_winner?(win_array, player_array)
        permutations = player_array.permutation(3) { |permutation| player_array += permutation }
        win_array.any? { |array|
        array == permutations
        }
    end

end

class GameTools
    include Game
    include GridCreator
    include GridUpdate
    include AddToPlayerArray
    include VictoryCheck

    @@board = [1, 2, 3, 4, 5, 6, 7, 8, 9]
    @@victory = [[1,2,3], [4,5,6], [7,8,9], [1,4,7], [2,5,8], [3,6,9], [1,5,9], [3,5,7]]
    
    def grid_display
        grid(@@board)
    end

    def begin_game
        game_begin()
    end

end

class Player < GameTools

    attr_reader :name, :symbol
    attr_accessor :array, :player_choice

    def initialize(name, symbol)
        @name = name
        @symbol = symbol
        @array = Array.new
        @player_choice = ""
    end

    def player_array_update
        add_to_array(@array, @player_choice)
    end

    def grid_update
        replace(@@board, @player_choice, @symbol)
    end

    def win_check
        is_winner?(@@victory, @array)
    end

end

game = GameTools.new

game.begin_game

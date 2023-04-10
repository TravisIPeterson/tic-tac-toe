module GridCreator

    def grid(array)
        puts " #{array[0]} | #{array[1]} | #{array[2]}"
        puts " ---------"
        puts " #{array[3]} | #{array[4]} | #{array[5]}"
        puts " ---------"
        puts " #{array[6]} | #{array[7]} | #{array[8]}"
        puts "\nWhich space would you like to claim?"
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
        permutations = player_array.permutation(3).to_a
        win_array.any? { |array|
        array == permutations
        }
    end

end

class GameTools
    include GridCreator
    include GridUpdate
    include AddToPlayerArray
    include VictoryCheck

    @@board = [1, 2, 3, 4, 5, 6, 7, 8, 9]
    @@victory = [[1,2,3], [4,5,6], [7,8,9], [1,4,7], [2,5,8], [3,6,9], [1,5,9], [3,5,7]]

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

class Player < GameTools

    attr_reader :name, :symbol
    attr_accessor :array, :player_choice

    def initialize(name, symbol)
        @name = name
        @symbol = symbol
        @array = Array.new
        @player_choice = ""
    end

end
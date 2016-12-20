class ChessBoard

  attr_reader :board

  def initialize
    @board = nil

    create_board
    puts "Finished"
  end

  def knight_moves(start, finish)
  end

  private

  def create_board
    # Create a list of all possible coordinates on the chess board,
    # then create a hash with the coords as keys, and node objects with those cords as values
    board_squares = [*(0..7)].product([*(0..7)])
    board_nodes = Hash.new
    board_squares.each { |x| board_nodes[x] = Node.new(x) }
    puts "NodeKeys #{board_nodes.keys}"
    # Create a list of the eight relative moves a knight can make from any position
    move_ranges = [-1, -2, 2, 1].product([-1, -2, 2, 1]).select { |x| x[0].abs != x[1].abs }
    # Iterate over the boards cordinates, and connect each node at that coordinate
    # with those nodes a knight can move to in one move.
    valid_moves = Array.new
    board_squares.each do |square|
      puts "Square #{square}"
      valid_moves.clear
      # For each relative move range,
      # append to valid_moves an absolute move relative to the current square
      move_ranges.each do |range|
        valid_moves << [square[0] + range[0], square[1] + range[1]]
      end
      puts "Valid Moves #{valid_moves}"
      # For each valid move, have the node reference those coordinates.
      valid_moves.each do |move|
        unless board_nodes[move].nil?
          board_nodes[square].connections << move
        end
      end
      puts "=============="
    end
    # Set position(root) instance variable
    @board = board_nodes
  end
end

class Node

  attr_accessor :connections
  attr_reader   :coord

  def initialize(coord)
    self.coord = coord # This will force the custom setter action
    @connections = Array.new
  end

  def coord=(value)
    unless (value.is_a? Array) &&
           value.length == 2 &&
           value.select { |x| (x.is_a? Integer) && (x.between? 0, 7) } == value
      raise ArgumentError, "coord must be an array of two integers in the range [0,0] - [7,7]"
    end

    @coord = value
  end
end

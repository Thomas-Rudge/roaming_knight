require_relative 'node.rb'

class Board
  def initialize
    @root  = nil
    @route = Array.new
  end

  def knight_moves(start, finish)
    find_path(start, finish)
    generate_route
    @route.reverse!
    print_board
    puts "You can get to that square in #{@route.length-1} moves."
    @route.each { |x| puts "#{x}" } ; nil
  end

  private

  def find_path(start, finish)
    node  = Node.new(start, nil)
    queue = [node]

    loop do
      node = queue.shift
      break if node.coord == finish
      create_children(node).each { |n| queue << Node.new(n, node) }
    end

    @root = node
  end

  def create_children(parent)
    coord = parent.coord
    children = Array.new

    [-1, -2, 2, 1].product([-1, -2, 2, 1]).select { |x| x[0].abs != x[1].abs }.each do |move|
      move = [move[0] + coord[0], move[1] + coord[1]]
      children << move if (move[0].between? 0, 7) && (move[1].between? 0, 7)
    end

    children
  end

  def generate_route
    @route.clear
    node = @root

    until node.nil?
      @route << node.coord
      node    = node.parent
    end
  end

  def print_board
    x = {nil=>" ",0=>"1", 1=>"2", 2=>"3", 3=>"4", 4=>"5", 5=>"6", 6=>"7"}
    puts "  ___ ___ ___ ___ ___ ___ ___ ___"

    (7).downto(0) do |i|
      print "#{i}| #{x[@route.index([0, i])]} | #{x[@route.index([1, i])]} | "
      print "#{x[@route.index([2, i])]} | #{x[@route.index([3, i])]} | "
      print "#{x[@route.index([4, i])]} | #{x[@route.index([5, i])]} | "
      puts  "#{x[@route.index([6, i])]} | #{x[@route.index([7, i])]} |"
      puts  " |___|___|___|___|___|___|___|___|"
    end

    puts "   0   1   2   3   4   5   6   7"
    puts ""
  end
end

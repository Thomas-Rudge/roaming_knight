class Node

  attr_accessor :parent
  attr_reader   :coord

  def initialize(coord, parent)
    self.coord   = coord # This will force the custom setter action
    @parent      = parent
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

class Cell
  attr_accessor :x, :y

  def intialize(world, x = 0, y = 0)
    @world = world
    @x = x
    @y = y
    world.cells << self
  end


  def produce_at(x,y)
    Cell.new(x,y)
  end

  def die
    world.cells -= self
  end

  def dead?
    !world.cells.include?(self)
  end


  def alive
    world.cells.include?(self)
  end

  def neighbours
    @neighbours = []

    #has a cell to the north
    world.cells.each do |cell|
      if self.x == cell.x && self.y == cell.y - 1
        @neighbours << cell
      end

      #has a cell to the North east
      if self.x == cell.x - 1 && self.y == cell.y - 1
        @neighbours << cell
      end

      #has a cell to the west
      if self.x == cell.x - 1 && self.y == cell.y
        @neighbours << cell
      end

      #has a cell to the east
      if self.x == cell.x - 1 && self.y == cell.y
        @neighbours << cell
      end
    end

    @neighbours
  end
end
#end of Cell class

class World
  attr_accessor :cells

  def intialize
    @cells = []
  end

  def tick!
    cells.each do |cell|
      if cell.neighbours < 2
        cell.die!
      end
    end
  end

end
#end of world class

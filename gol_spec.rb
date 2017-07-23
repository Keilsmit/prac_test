require 'rspec'

class Cell
  attr_accessor :world, :x, :y

  def intialize(world, x=0, y=0)
    @world = world,
    @x = x,
    @y = y
    world.cells << self
  end

  def die
    world.cells -= [self]
  end

  def dead?
    !world.cells.include?(self)
  end

  def alive
    world.cells.include?(self)
  end

  def neighbours
    @neighbours = []
    #has a cell to the North
    world.cells.each do |cell|
      if self.x == cell.x && self.y == cell.y - 1
        @neighbours << cell
      end

      #has a cell to the north east
      if self.x == cell.x - 1 && self.y == cell.y - 1
        @neighbours << cell
      end

      #has a cell to the west
      if self.x == cell.x + 1 && self.y == cell.y
        @neighbours << cell
      end

      #has a cell to the east
      if self.x == cell.x - 1 && self.y == cell.y
        @neighbours << cell
      end
    end

      @neighbours
  end

  def produce_at(x,y)
    Cell.new(world, x,y)
  end
end
#End of Cell class

class World
  attr_accessor :cells

  def intialize
    @cells = []
  end

  def tick!
    cells.each do |cell|
      if cell.neighbors < 2
        cell.die!
      end
    end
  end

end
#End of World class

#RSPEC test for game_of_life
describe 'game of life' do
  let(:world){World.new}

  context "cell helper methods" do
    subject {Cell.new(world)}
      it "spawn relative to" do
        cell = subject.produce_at(3,5)
        cell.is_a?(cell).should be_true?
        cell.x.should == 3
        cell.y.should == 5
        cell.world.should == subject.world
      end

      it "detect neighbour to the north" do
        cell = subject.produce_at(0,1)
        subject.neighbours.count.should == 1
      end

      it "detect neighbour to the north east" do
        cell = subject.produce_at(1,1)
        subject.neighbours.count.should == 1
      end

      it "detects a neighbour to the west" do
        cell = subject.produce_at(-1, 0)
        subject.neighbours.count.should == 1
      end

      it "detects a neighbour to the east" do
        cell = subject.produce_at(1,0)
        subject.neighbours.count.should == 1
      end

      it "dies" do
        subject.die!
        subject.world.cells.should_not include(subject)
      end
  end

   it "Rule 1: Any live cell with fewer than two live neighbours dies, as if caused by underpopulation." do
     cell = Cell.new(world)
     new_cell = cell.produce_at(2,0)
    #  cell.neighbours.count.should == 0
    cell.tick!
    cell.should be_dead?
   end

   it "Rule 2: Any live cell with two or three live neighbours lives on to the next generation." do
     cell = Cell.new(world)
     new_cell = cell.produce_at(1,0)
     another_new_cell = cell.produce_at(-1,0)
     world.tick!
     cell.should be_alive
   end
 end

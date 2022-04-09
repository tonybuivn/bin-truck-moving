# frozen_string_literal: true

# TODO : fix this
# creates a Truck that is parked in Neighbourhood
class Truck
  attr_reader :x_coordinate, :y_coordinate, :direction

  NORTH = 'north'
  SOUTH = 'south'
  EAST = 'east'
  WEST = 'west'

  direction_list = [NORTH, EAST, SOUTH, WEST]

  def initialize
    @x_coordinate = 0
    @y_coordinate = 0
    @direction = NORTH
  end

  def park(x_coordinate, y_coordinate, direction)
    if x_coordinate.negative? || x_coordinate > 6 || y_coordinate.negative? || y_coordinate > 6
      raise 'Cannot park beyond the Neighbourhood'
    end

    @x_coordinate = x_coordinate
    @y_coordinate = y_coordinate
    @direction = direction
    [@x_coordinate, @y_coordinate]
  end

  def drive
    raise 'Cannot go beyond the Neighbourhood' if border_coordinate?

    case @direction
    when NORTH
      @y_coordinate += 1
    when SOUTH
      @y_coordinate -= 1
    when EAST
      @x_coordinate += 1
    when WEST
      @x_coordinate -= 1
    end
  end

  def turn_right
    @direction = direction_list.at((direction_list.find_index(@direction) + 1) % 4)
  end

  def turn_left
    @direction = direction_list.at((direction_list.find_index(@direction) - 1) % 4)
  end

  private

  def border_coordinate? # rubocop:disable Metrics/CyclomaticComplexity
    @x_coordinate.zero? && @direction == WEST ||
      @x_coordinate == 6 && @direction == EAST ||
      @y_coordinate.zero? && @direction == SOUTH ||
      @y_coordinate == 6 && @direction == NORTH
  end
end

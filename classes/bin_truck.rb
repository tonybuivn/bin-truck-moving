# frozen_string_literal: true

require './truck_error'

# Bin Truck class
class BinTruck
  attr_reader :x_coor, :y_coor, :direction, :neighborhood

  NORTH = 'NORTH'
  SOUTH = 'SOUTH'
  EAST = 'EAST'
  WEST = 'WEST'

  DIRECTION_LIST = [NORTH, EAST, SOUTH, WEST].freeze
  DIRECTIONS_NUMBER = 4
  MOVEMENT_UNIT = 1
  BIN_DISTANCE_UNIT = 1

  def initialize(neighborhood)
    @x_coor = -1
    @y_coor = -1
    @neighborhood = neighborhood
    @direction = NORTH
    @inside_area = false
  end

  def park(x_coor, y_coor, direction)
    raise TruckError::InvalidPosition, 'ERROR: Cannot park outside the neighborhood' if outside_area?(x_coor, y_coor)
    raise TruckError::InvalidDirection, 'ERROR: Invalid direction' unless DIRECTION_LIST.include?(direction)

    @x_coor = x_coor
    @y_coor = y_coor
    @direction = direction
    @inside_area = true
    self
  end

  def drive
    validate_position
    raise TruckError::InvalidMovement, 'ERROR: Cannot move beyond the neighborhood' if facing_to_borderline?

    @y_coor += MOVEMENT_UNIT if facing?(NORTH)
    @y_coor -= MOVEMENT_UNIT if facing?(SOUTH)
    @x_coor += MOVEMENT_UNIT if facing?(EAST)
    @x_coor -= MOVEMENT_UNIT if facing?(WEST)
    self
  end

  def turn_right
    validate_position

    @direction = DIRECTION_LIST.at((DIRECTION_LIST.find_index(@direction) + 1) % DIRECTIONS_NUMBER)
    self
  end

  def turn_left
    validate_position

    @direction = DIRECTION_LIST.at((DIRECTION_LIST.find_index(@direction) - 1) % DIRECTIONS_NUMBER)
    self
  end

  def pickup # rubocop:disable Metrics/CyclomaticComplexity
    validate_position
    raise TruckError::BinOutofArea, 'Bin is out of the neighborhood' if bin_outside_area?

    bin_x_coor = @x_coor - BIN_DISTANCE_UNIT if facing?(NORTH)
    bin_x_coor = @x_coor + BIN_DISTANCE_UNIT if facing?(SOUTH)
    bin_y_coor = @y_coor - BIN_DISTANCE_UNIT if facing?(EAST)
    bin_y_coor = @y_coor + BIN_DISTANCE_UNIT if facing?(WEST)

    [bin_x_coor || @x_coor, bin_y_coor || @y_coor]
  end

  def call_central
    validate_position

    puts "#{@x_coor}, #{@y_coor}, #{@direction}"
  end

  private

  def facing_to_borderline?
    in_border_with_direction?(@x_coor, @neighborhood.lower_border, WEST) ||
      in_border_with_direction?(@x_coor, @neighborhood.upper_border, EAST) ||
      in_border_with_direction?(@y_coor, @neighborhood.lower_border, SOUTH) ||
      in_border_with_direction?(@y_coor, @neighborhood.upper_border, NORTH)
  end

  def bin_outside_area?
    in_border_with_direction?(@x_coor, @neighborhood.lower_border, NORTH) ||
      in_border_with_direction?(@y_coor, @neighborhood.upper_border, EAST) ||
      in_border_with_direction?(@x_coor, @neighborhood.upper_border, SOUTH) ||
      in_border_with_direction?(@y_coor, @neighborhood.lower_border, WEST)
  end

  def validate_position
    raise TruckError::InvalidPosition, 'ERROR: Need to be in the neighborhood before start moving' unless inside_area?
  end

  def outside_area?(x_coor, y_coor)
    x_coor < @neighborhood.lower_border ||
      x_coor > @neighborhood.upper_border ||
      y_coor < @neighborhood.lower_border ||
      y_coor > @neighborhood.upper_border
  end

  def inside_area?
    @inside_area
  end

  def facing?(direction)
    @direction == direction
  end

  def in_border_with_direction?(coor_type, border_type, direction)
    coor_type == border_type && facing?(direction)
  end
end

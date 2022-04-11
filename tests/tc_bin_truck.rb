# frozen_string_literal: true

require './classes/bin_truck'
require './truck_error'
require 'test/unit'
require 'pry'

# Unit-test for BinTruck Class
class TestBinTruck < Test::Unit::TestCase
  def setup
    @bin_truck = BinTruck.new
  end

  def test_initialization
    assert_equal @bin_truck.respond_to?(:park), true, 'Bin Truck should be able to be parked'
  end

  def test_park
    assert_raise(TruckError::InvalidPosition) { @bin_truck.park(-1, 2, 'NORTH') }
    assert_raise(TruckError::InvalidDirection) { @bin_truck.park(1, 2, 'NOWHERE') }

    @bin_truck.park(1, 2, 'NORTH')
    assert_equal [1, 2, 'NORTH'], bin_truck_info(@bin_truck), 'ERROR: Truck should be parked at [1,2] and facing NORTH'
  end

  def test_invalid_drive
    assert_raise(TruckError::InvalidPosition) { @bin_truck.drive }

    # Test 4 invalid movement cases
    assert_raise(TruckError::InvalidMovement) { @bin_truck.park(0, 2, 'WEST').drive }
    assert_raise(TruckError::InvalidMovement) { @bin_truck.park(6, 2, 'EAST').drive }
    assert_raise(TruckError::InvalidMovement) { @bin_truck.park(2, 0, 'SOUTH').drive }
    assert_raise(TruckError::InvalidMovement) { @bin_truck.park(2, 6, 'NORTH').drive }
  end

  def test_valid_drive
    @bin_truck.park(1, 2, 'NORTH').drive
    assert_equal [1, 3, 'NORTH'], bin_truck_info(@bin_truck), 'ERROR: Truck should be parked at [1,3] and facing NORTH'
  end

  def test_turn_right
    assert_raise(TruckError::InvalidPosition) { @bin_truck.turn_right }

    @bin_truck.park(1, 2, 'NORTH').turn_right
    assert_equal [1, 2, 'EAST'], bin_truck_info(@bin_truck), 'ERROR: Truck should be parked at [1,2] and facing EAST'
  end

  def test_turn_left
    assert_raise(TruckError::InvalidPosition) { @bin_truck.turn_left }

    @bin_truck.park(1, 2, 'NORTH').turn_left
    assert_equal [1, 2, 'WEST'], bin_truck_info(@bin_truck), 'ERROR: Truck should be parked at [1,2] and facing WEST'
  end

  def test_invalid_pickup
    assert_raise(TruckError::InvalidPosition) { @bin_truck.pickup }

    # When Bin is out of the neighborhood
    assert_raise(TruckError::BinOutofArea) { @bin_truck.park(0, 2, 'NORTH').pickup }
    assert_raise(TruckError::BinOutofArea) { @bin_truck.park(6, 2, 'SOUTH').pickup }
    assert_raise(TruckError::BinOutofArea) { @bin_truck.park(2, 0, 'WEST').pickup }
    assert_raise(TruckError::BinOutofArea) { @bin_truck.park(2, 6, 'EAST').pickup }
  end

  def test_valid_pickup
    assert_equal [0, 2], @bin_truck.park(1, 2, 'NORTH').pickup, 'ERROR: Bin should be picked at [0,2]'
  end

  def test_call_central
    assert_raise(TruckError::InvalidPosition) { @bin_truck.call_central }
  end

  private

  def bin_truck_info(bin_truck)
    [bin_truck.x_coor, bin_truck.y_coor, bin_truck.direction]
  end
end

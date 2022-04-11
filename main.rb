# frozen_string_literal: true

require_relative 'classes/bin_truck'
require './truck_error'
require 'pry'

bin_truck = BinTruck.new

loop do # rubocop:disable Metrics/BlockLength
  puts
  puts 'Enter a commmand [PARK, DRIVE, LEFT, RIGHT, PICKUP, CALLCENTRAL, EXIT]'

  command_input = gets
  command_input.chomp!.upcase!

  if command_input =~ /^PARK/
    params = command_input.split(' ')[1]&.split(',') # => [x, y, direction]

    if params.nil? || params.size != 3
      puts 'ERROR: Invalid park command'
      next
    end

    begin
      bin_truck.park(params[0].to_i, params[1].to_i, params[2])
    rescue TruckError::InvalidPosition, TruckError::InvalidDirection => e
      puts e.message
    end
    next
  end

  begin
    case command_input
    when 'DRIVE'
      bin_truck.drive
      next
    when 'LEFT'
      bin_truck.turn_left
      next
    when 'RIGHT'
      bin_truck.turn_right
      next
    when 'PICKUP'
      bin_x_coor, bin_y_coor = bin_truck.pickup
      puts "BIN PICKED AT #{bin_x_coor}, #{bin_y_coor}"
      next
    when 'CALLCENTRAL'
      bin_truck.call_central
      next
    when 'EXIT'
      break
    else
      puts 'ERROR: Invalid command'
    end
  rescue TruckError::InvalidPosition, TruckError::InvalidMovement, TruckError::BinOutofArea => e
    puts e.message
  end
end

# frozen_string_literal: true

# TODO: fix this
# Neighbourhood surface with diomensions 7 column by 7 rows
class Neigbourhood
  attr_accessor :x_axis, :y_axis

  def initialize
    @x_axis = [0, 1, 2, 3, 4, 5, 6]
    @y_axis = [0, 1, 2, 3, 4, 5, 6]
  end
end

# frozen_string_literal: true

# Neighbourhood creates surface with diomensions is determined by upper and lower border
class Neighborhood
  attr_reader :upper_border, :lower_border

  def initialize(upper_border, lower_border)
    @upper_border = upper_border
    @lower_border = lower_border
  end
end

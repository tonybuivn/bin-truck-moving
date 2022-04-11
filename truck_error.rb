# frozen_string_literal: true

module TruckError
  class InvalidPosition < StandardError; end
  class BinOutofArea < StandardError; end
  class InvalidDirection < StandardError; end
  class InvalidMovement < StandardError; end
end

require 'date'
require 'pry'

module Hotel
  TOTAL_ROOMS = 20
  COST_PER_NIGHT = 200
  class User
    attr_reader :rooms
    def initialize
      @rooms = []
      TOTAL_ROOMS.times { | room_num | @rooms << room_num + 1}
    end
  end
end

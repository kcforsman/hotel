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
    def reserve_room(guest, start_date, end_date)
      if start_date.class != Date || end_date.class != Date
        raise StandardError.new("not a date")
      elsif end_date < start_date
        raise ArgumentError.new("End date (#{end_date}) comes before start date (#{start_date})")
      elsif end_date == start_date
        raise ArgumentError.new("End date (#{end_date}) is same as start date (#{start_date})")
      end
    end
  end
end

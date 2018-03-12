require 'date'
require 'pry'

module Hotel
  class Room
    attr_reader :room_num, :calendar, :cost
    def initialize(room_num, cost)
      @room_num = room_num
      @cost = cost
      @calendar = []
    end
    def add_to_calendar(date_range)
      dates = date_range.to_a
      dates.each { | date | @calendar << date }
    end
  end
end

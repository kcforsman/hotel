require 'date'
require 'pry'

module Hotel
  class Block < User
    attr_reader :id
    def initialize(id, rooms, party, date_range, discount)
      @id = id
      @rooms = rooms
      @party = party
      @date_range = date_range
      @discount = discount
      @reservations = []
    end

    def find_available_rooms
      available_rooms = []
      @rooms.each do |room|
        next if room.calendar.any?(@date_range) # this apparently works
        # next if room.calendar.any?{ |date| @date_range.include?(date) }
        # ^ alternative solution that actually make more sense to me ^
        available_rooms << room
      end
      available_rooms
      # need to deal with no rooms available
    end
  end
end

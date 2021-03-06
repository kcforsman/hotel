require 'date'

module Hotel
  class Reservation
    attr_reader :id
    def initialize reservation_args
      @id = reservation_args[:id]
      @room = reservation_args[:room]
      @guest = reservation_args[:guest]
      @date_range = reservation_args[:date_range]
    end

    def calculate_nights
      @date_range.to_a.length
    end

    def find_all_dates
      @date_range.to_a
    end

    def calculate_reservation_cost
      @room.calculate_cost(calculate_nights)
    end
  end
end

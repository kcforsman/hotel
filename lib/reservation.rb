require 'date'

module Hotel
  class Reservation
    attr_reader :id, :room_num, :guest, :date_range
    def initialize id, room_num, guest, date_range
      @id = id
      @room_num = room_num
      @guest = guest
      @date_range = date_range
    end

    def calculate_nights
      @date_range.to_a.length
    end

    def find_all_dates
      @date_range.to_a
    end

    def calculate_reservation_cost
      calculate_nights * COST_PER_NIGHT
    end
  end
end

require 'date'

module Hotel
  class Reservation
    attr_reader :id, :room_num, :guest, :start_date, :end_date
    def initialize id, room_num, guest, start_date, end_date
      @id = id
      @room_num = room_num
      @guest = guest
      @start_date = start_date
      @end_date = end_date
    end

    def calculate_nights
      (end_date - start_date).to_i
    end

    def find_all_dates
      date_range = []
      date = @start_date
      while date <= @end_date
        date_range << date
        date += 1
      end
      date_range
    end

  end
end

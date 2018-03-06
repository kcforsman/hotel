require 'date'
require 'pry'

module Hotel
  TOTAL_ROOMS = 20
  COST_PER_NIGHT = 200
  class User
    attr_reader :rooms
    def initialize
      @rooms = []
      @reservations = []
      @calendar = {}
      TOTAL_ROOMS.times { | room_num | @rooms << room_num + 1}
    end
    def reserve_room(room_num, guest, start_date, end_date)
      valid_dates(start_date, end_date)
      id = @reservations.length
      new_reservation = Reservation.new(id, room_num, guest, start_date, end_date)
      @reservations << new_reservation
      new_reservation
    end

    def valid_dates(start_date, end_date)
      if start_date.class != Date || end_date.class != Date
        raise StandardError.new("not a date")
      elsif end_date < start_date
        raise StandardError.new("End date (#{end_date}) comes before start date (#{start_date})")
      elsif end_date == start_date
        raise StandardError.new("End date (#{end_date}) is same as start date (#{start_date})")
      end
    end

  end
end

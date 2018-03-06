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
      id = @reservations.length + 1
      new_reservation = Reservation.new(id, room_num, guest, start_date, end_date)
      add_to_calendar(new_reservation)
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

    def add_to_calendar(reservation)
      date_range = reservation.find_all_dates
      date_range.each do |date|
         @calendar[date] ? @calendar[date].push(reservation) : @calendar[date] = [reservation]
       end
    end

    def find_reservations_for_given_date(date)
      @calendar[date]
    end

    def find_reservation_cost(reservation_id)
      reservation = find_reservation(reservation_id)
      reservation.calculate_reservation_cost
    end
    def find_reservation(reservation_id)
      @reservations.find { |reservation| reservation.id == reservation_id }
    end
  end
end

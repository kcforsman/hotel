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
      TOTAL_ROOMS.times { | room_num | @rooms << Room.new(room_num + 1)}
    end
    def find_available_rooms(start_date, end_date)
      date_range = (start_date...end_date)
      available_rooms = []
      @rooms.each do |room|
        next if room.calendar.any?(date_range) # this apparently works
        # next if room.calendar.any?{ |date| date_range.include?(date) }
        # ^ alternative solution that actually make more sense to me ^
        available_rooms << room
      end
      available_rooms
      # need to deal with no rooms available
    end

    def reserve_room(room_num, guest, start_date, end_date)
      valid_dates(start_date, end_date)
      date_range = (start_date...end_date)
      check_room_availibility(room_num, date_range)
      room = @rooms[room_num - 1]
      id = @reservations.length + 1
      new_reservation = Reservation.new(id, room, guest, date_range)
      add_to_calendar(new_reservation, date_range)
      room.add_to_calendar(date_range)
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

    def check_room_availibility(room_num, date_range)
      calendar = @rooms[room_num - 1].calendar
      return true if calendar.empty?
      calendar.each do |date|
        raise StandardError.new("room already reserved") if date_range.include?(date)
      end
    end

    def add_to_calendar(reservation, date_range)
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

    def create_room_block(rooms, party, start_date, end_date, discount)
      raise StandardError.new('too many rooms for a block') if rooms.length > 5
      raise StandardError.new('too few rooms for a block') if rooms.length < 2
      valid_dates(start_date, end_date)
      date_range = (start_date...end_date)
      rooms.each { |room| check_room_availibility(room.room_num, date_range) }
      id = @reservations.length + 1
      new_block = Block.new(id, rooms, party, date_range, discount)
      add_to_calendar(new_block, date_range)
      rooms.each { |room| room.add_to_calendar(date_range) }
      @reservations << new_block
      new_block
    end

    def reserve_room_from_block(block, room_num, guest)
      block.reserve_room(room_num, guest)
    end
  end
end

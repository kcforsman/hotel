require 'date'
require 'pry'

module Hotel
  class Block < Reservation
    attr_reader :id, :reservations
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
      return @rooms if @reservations.empty?
      @rooms.each do |room|
        next if @reservations.any? { |reservation| reservation.room == room }
        available_rooms << room
      end
      raise StandardError.new("no rooms available") if available_rooms.empty?
      available_rooms
    end

    def reserve_room(room_num, guest)
      room = @rooms[room_num - 1]
      raise StandardError.new("room not available") if !find_available_rooms.include?(room)
      id = @reservations.length + 1
      new_reservation = Reservation.new(id, room, guest, @date_range)
      @reservations << new_reservation
      new_reservation
    end

    def calculate_reservation_cost(reservation_id)
      reservation = find_reservation(reservation_id)
      ((1 - @discount) * reservation.calculate_reservation_cost).round(2)
    end

    def find_reservation(reservation_id)
      @reservations.find { |reservation| reservation.id == reservation_id }
    end
  end
end

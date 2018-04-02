require 'date'
require 'pry'

module Hotel
  class Block < Reservation
    @@id = 1
    attr_reader :id
    def initialize block_args
      super(block_args)
      @party = block_args[:party]
      @rooms = block_args[:rooms]
      @discount = block_args[:discount]
      @reservations = []
      @reserved_rooms = []
    end

    def find_available_rooms
      available_rooms = []
      return @rooms if @reserved_rooms.empty?
      @rooms.each do |room|
        next if @reserved_rooms.any? { |reserved_room| reserved_room == room }
        available_rooms << room
      end
      raise StandardError.new("no rooms available") if available_rooms.empty?
      available_rooms
    end

    def reserve_room(room_num, guest)
      room = @rooms[room_num - 1]
      raise StandardError.new("room not available") if !find_available_rooms.include?(room)
      new_reservation = Reservation.new({id: @@id, room: room, guest: guest, date_range: @date_range})
      @@id += 1
      @reserved_rooms << room
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

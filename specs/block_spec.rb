require_relative 'spec_helper'
require 'date'
require 'pry'

describe 'Block class' do
  describe 'instantiation' do
    before do
      rooms = []
      4.times {|x| rooms << Hotel::Room.new(x+1) }
      date_range = (Date.new(2018,3,22)...Date.new(2018,3,26))
      @block = Hotel::Block.new(1, rooms, "Fanime", date_range, 0.2)
    end
    it 'can be initialized' do
      @block.must_be_instance_of Hotel::Block
    end
    it 'inherits from User' do
      @block.must_be_kind_of Hotel::User
    end
    it 'has attributes: id, list of some rooms, reservations, party, date range, discount' do
      # may not need this test stub....
      @block.must_respond_to :id
      @block.id.must_equal 1
    end
  end
  describe 'find_available_rooms' do
    before do
      @rooms = []
      4.times {|x| @rooms << Hotel::Room.new(x+1) }
      date_range = (Date.new(2018,3,22)...Date.new(2018,3,26))
      @block = Hotel::Block.new(1, @rooms, "Fanime", date_range, 0.2)
    end
    it 'returns array of rooms available in block' do
      available_rooms_in_block = @block.find_available_rooms

      available_rooms_in_block.must_be_kind_of Array
      available_rooms_in_block.must_equal @rooms
    end
    it 'handles (throw exception or returns nil) no rooms available' do
      4.times do |x|
        @block.reserve_room(x+1, "fan #{x+1}")
      end

      proc { @block.find_available_rooms }.must_raise StandardError
    end
    it 'exclude rooms that are already reserved' do
      @block.reserve_room(1, "Fan 543")
      @block.reserve_room(3, "Fan 564")

      available_rooms_in_block = @block.find_available_rooms

      available_rooms_in_block.wont_include @rooms[0]
      available_rooms_in_block.wont_include @rooms[2]
    end
  end
  describe 'reserve_room' do
    before do
      rooms = []
      4.times {|x| rooms << Hotel::Room.new(x+1) }
      date_range = (Date.new(2018,3,22)...Date.new(2018,3,26))
      @block = Hotel::Block.new(1, rooms, "Fanime", date_range, 0.2)
    end
    it 'returns a reservation for an available room' do
      reservation = @block.reserve_room(1, "Fan 1")

      reservation.must_be_instance_of Hotel::Reservation
    end
    it 'throws exception if room is unavailable' do
      @block.reserve_room(2, "Jace Poe")
      proc { @block.reserve_room(2, "Jade Poe")}.must_raise StandardError
    end
  end
  describe 'find_reservation_cost' do
    before do
      rooms = []
      4.times {|x| rooms << Hotel::Room.new(x+1) }
      date_range = (Date.new(2018,3,22)...Date.new(2018,3,26))
      @block = Hotel::Block.new(1, rooms, "Fanime", date_range, 0.2)
    end
    it 'returns discounted cost for the reservation' do
      @block.reserve_room(1, "Meka Starbright")

      @block.find_reservation_cost(1).must_equal 640
    end
  end
end

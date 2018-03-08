require_relative 'spec_helper'
require 'date'

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
    xit 'handles (throw exception or returns nil) no rooms available' do
      4.times { |x| @block.reserve_room(x+1, "Guest #{x+1}") }
      proc { available_rooms_in_block = @block.find_available_rooms }.must_raise StandardError
    end
    xit 'exclude rooms that are already reserved' do

    end
  end
  describe 'reserve_room' do
    it 'returns a reservation for an available room' do

    end
    it 'throws exception if room is unavailable' do

    end
  end
  describe 'find_reservation_cost' do
    it 'returns discounted cost for the reservation' do

    end
  end
end

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
  describe 'check_room_availibility' do
    it 'returns array of rooms available in block' do

    end
    it 'handles (throw exception or returns nil) no rooms available' do

    end
    it 'exclude rooms that are already reserved' do

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
require_relative 'spec_helper'
require 'date'

describe 'User' do
  describe 'initialization' do
    before do
      @admin = Hotel::User.new
    end
    it 'can be initialized' do
      @admin.must_be_instance_of Hotel::User
    end
    it 'has a list of rooms' do
      @admin.must_respond_to :rooms
    end
  end
  describe 'reserve_room' do
    before do
      @admin = Hotel::User.new
    end
    it 'throws StandardError for invalidate dates' do
      proc { @admin.reserve_room("Jade Poe", nil, Date.new(2018,3,5))}.must_raise StandardError
      proc { @admin.reserve_room("Jade Poe", Date.new(2018,3,5), nil)}.must_raise StandardError
    end
    it 'throws ArgumentError if end_date occurs before start_date' do
      proc { @admin.reserve_room("Jade Poe", Date.new(2018, 3, 10), Date.new(2018, 3, 5))}.must_raise ArgumentError
    end
    it 'throws ArgumentError if start_date is same as end_date' do
      proc { @admin.reserve_room("Jade Poe", Date.new(2018, 3, 10), Date.new(2018, 3, 10))}.must_raise ArgumentError
    end
    it 'returns an instance of a reservation' do
    end
  end
  xdescribe 'find_reservations_for_given_date' do
    it 'returns array of reservations for a given date' do
    end
  end
  xdescribe 'calculate_reservation_cost' do
    it 'returns cost for reservation' do
    end
  end

end

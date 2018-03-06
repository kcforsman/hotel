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
      @new_reservation = @admin.reserve_room(5, "Jade Poe", Date.new(2018, 3, 20), Date.new(2018, 3, 25))
    end
    it 'throws StandardError for invalidate dates' do
      proc { @admin.reserve_room(3, "Jade Poe", nil, Date.new(2018,3,5))}.must_raise StandardError
      proc { @admin.reserve_room(4, "Jade Poe", Date.new(2018,3,5), nil)}.must_raise StandardError
    end
    it 'throws StandardError if end_date occurs before start_date' do
      proc { @admin.reserve_room(1, "Jade Poe", Date.new(2018, 3, 10), Date.new(2018, 3, 5))}.must_raise StandardError
    end
    it 'throws StandardError if start_date is same as end_date' do
      proc { @admin.reserve_room(2, "Jade Poe", Date.new(2018, 3, 10), Date.new(2018, 3, 10))}.must_raise StandardError
    end
    it 'throws StandardError if room has any other reservation that overlaps with new reservation' do
    end
    it 'returns an instance of a reservation' do
      @new_reservation.must_be_instance_of Hotel::Reservation
    end
  end
  describe 'find_reservations_for_given_date' do
    before do
      @admin = Hotel::User.new
      @new_reservation = @admin.reserve_room(5, "Jade Poe", Date.new(2018, 3, 20), Date.new(2018, 3, 25))
      @new_reservation_2 = @admin.reserve_room(8, "Kal Smith", Date.new(2018, 3, 20), Date.new(2018, 3, 25))
      @date = Date.new(2018, 3, 23)
    end
    it 'returns array of reservations for a given date' do
      reservations_of_day = @admin.find_reservations_for_given_date(@date)

      reservations_of_day.must_be_kind_of Array
      reservations_of_day.must_equal [@new_reservation, @new_reservation_2]
    end
  end
  describe 'find_reservation_cost' do
    it 'returns cost for reservation with reservation id' do
      admin = Hotel::User.new
      admin.reserve_room(5, "Kaeli Poe", Date.new(2018, 3, 20), Date.new(2018, 3, 25))

      admin.find_reservation_cost(1).must_equal 1000
    end
  end

end

require_relative 'spec_helper'
require 'date'

describe 'Reservation' do
  before do
    date_range = (Date.new(2018,3,18)...Date.new(2018,3,26))
    room = Hotel::Room.new(4, 200)
    @reservation = Hotel::Reservation.new({id: 1, room: room, guest: "Bob", date_range: date_range})
  end
  describe 'initialization' do
    it 'can be initialized' do
      @reservation.must_be_instance_of Hotel::Reservation
    end
    it 'has attributes: id, room, guest, date_range' do
      @reservation.id.must_equal 1
      @reservation.id.must_be_kind_of Integer
      @reservation.room.must_be_instance_of Hotel::Room
      @reservation.date_range.must_be_kind_of Range
    end
  end
  describe 'calculate_nights' do
    before do
      date_range = (Date.new(2018,3,18)...Date.new(2018,3,26))
      room = Hotel::Room.new(4, 200)
      @reservation = Hotel::Reservation.new({id: 1, room: room, guest: "Bob", date_range: date_range})
    end
    it 'returns the number of nights' do
      nights = @reservation.calculate_nights

      nights.must_be_kind_of Integer
      nights.must_equal 8
    end
  end
  describe 'find_all_dates' do
    it 'returns an array of all dates in reservation' do
      date_range = (Date.new(2018,3,20)...Date.new(2018,3,22))
      room = Hotel::Room.new(4, 200)
      reservation = Hotel::Reservation.new({id: 1, room: room, guest: "Kaeli", date_range: date_range})
      all_dates = reservation.find_all_dates

      all_dates.must_be_kind_of Array
      all_dates.must_equal [Date.new(2018,3,20), Date.new(2018,3,21)]
    end
  end

  describe 'calculate_reservation_cost' do
    it 'returns the cost of the reservation' do
      date_range = (Date.new(2018,3,20)...Date.new(2018,3,25))
      room = Hotel::Room.new(4, 200)
      reservation = Hotel::Reservation.new({id: 1, room: room, guest: "Bob", date_range: date_range})

      reservation.calculate_reservation_cost.must_equal 1000
    end
  end
end

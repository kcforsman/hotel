require_relative 'spec_helper'
require 'date'

describe 'Reservation' do
  before do
    @reservation = Hotel::Reservation.new(1, 4, "Bob", Date.new(2018,3,26), Date.new(2018,3,18))
  end
  describe 'initialization' do
    it 'can be initialized' do
      @reservation.must_be_instance_of Hotel::Reservation
    end
    it 'has attributes: id, room_num, guest, start_date, end_date' do
      @reservation.id.must_equal 1
      @reservation.id.must_be_kind_of Integer
      @reservation.room_num.must_equal 4
      @reservation.room_num.must_be_kind_of Integer
      @reservation.guest.must_equal "Bob"
      @reservation.guest.must_be_kind_of String
      @reservation.start_date.must_be_instance_of Date
      @reservation.end_date.must_be_instance_of Date
    end
  end
  describe 'calculate_nights' do
    it 'returns the number of nights' do

    end
  end
end

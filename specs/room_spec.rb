require_relative 'spec_helper'
require 'date'

describe 'Room class' do
  describe 'initialize' do
    it 'can be initialized' do
      room_2 = Hotel::Room.new(2, 200)

      room_2.must_be_instance_of Hotel::Room
    end

    it 'has empty calendar and room number' do
      room_2 = Hotel::Room.new(2, 200)

      room_2.must_respond_to :room_num
      room_2.room_num.must_be_kind_of Integer
      room_2.room_num.must_equal 2
    end
  end
  describe 'add_to_calendar' do
    it 'can add a date_range to its calendar' do
      room = Hotel::Room.new(2, 200)
      date_range = (Date.new(2018,3,8)...Date.new(2018,3,10))

      room.add_to_calendar(date_range)

      room.is_available(Date.new(2018,3,9)).must_equal false
      room.is_available(Date.new(2018,3,10)).must_equal true
    end
  end
end

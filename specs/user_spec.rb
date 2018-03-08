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
      @admin.rooms[0].must_be_instance_of Hotel::Room
      @admin.rooms.last.must_be_instance_of Hotel::Room
    end
  end
  describe 'find_available_rooms' do
    before do
      @admin = Hotel::User.new
      @start_date = Date.new(2018,3,15)
      @end_date = Date.new(2018,3,20)
    end
    it 'returns a list of rooms that are available for a range of dates' do
      available_rooms = @admin.find_available_rooms(@start_date, @end_date)

      available_rooms.must_be_kind_of Array
      available_rooms.length.must_equal 20
      available_rooms[0].must_be_instance_of Hotel::Room
      available_rooms[8].must_be_instance_of Hotel::Room
      available_rooms[-1].must_be_instance_of Hotel::Room
    end
    it 'handles (throw exception or returns nil) if no rooms available' do
    end
    it 'excludes rooms that arent available for given dates' do
      reservation1 = @admin.reserve_room(1, "Jane Doe", Date.new(2018,3,12), Date.new(2018,3,18))
      reservation2 = @admin.reserve_room(2, "John Smith", Date.new(2018,3,18), Date.new(2018,3,25))
      reservation3 = @admin.reserve_room(3, "Sam Sole", Date.new(2018,3,1), Date.new(2018,3,30))
      reservation4 = @admin.reserve_room(4, "Alex Whitt", Date.new(2018,3,15), Date.new(2018,3,20))
      reservation5 = @admin.reserve_room(5, "Kael Dear", Date.new(2018,3,16), Date.new(2018,3,18))

      available_rooms = @admin.find_available_rooms(@start_date, @end_date)

      available_rooms.wont_include reservation1.room
      available_rooms.wont_include reservation2.room
      available_rooms.wont_include reservation3.room
      available_rooms.wont_include reservation4.room
      available_rooms.wont_include reservation5.room
    end
    it 'includes rooms that have same end_date as new start date' do
      reservation1 = @admin.reserve_room(3, "Sam Sole", Date.new(2018,3,1), Date.new(2018,3,30))
      reservation2 = @admin.reserve_room(4, "Alex Whitt", Date.new(2018,3,12), Date.new(2018,3,15))

      available_rooms = @admin.find_available_rooms(@start_date, @end_date)

      available_rooms.wont_include reservation1.room
      available_rooms.must_include reservation2.room
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
      @admin.reserve_room(2, "Jace Poe", Date.new(2018, 3, 10), Date.new(2018, 3, 12))
      proc { @admin.reserve_room(2, "Jade Poe", Date.new(2018, 3, 10), Date.new(2018, 3, 12))}.must_raise StandardError
    end
    it 'returns an instance of a reservation' do
      @new_reservation.must_be_instance_of Hotel::Reservation
    end
    it 'allows reservation of room with same start_date as previous reservations end_date' do
      next_reservation = @admin.reserve_room(5, "Kaeli Smit", Date.new(2018, 3, 25), Date.new(2018, 3, 27))

      next_reservation.must_be_instance_of Hotel::Reservation
      next_reservation.date_range.must_equal (Date.new(2018, 3, 25)...Date.new(2018, 3, 27))
    end
  end
  describe 'find_reservation_cost' do
    it 'returns cost for reservation with reservation id' do
      admin = Hotel::User.new
      admin.reserve_room(5, "Kaeli Poe", Date.new(2018, 3, 20), Date.new(2018, 3, 25))

      admin.find_reservation_cost(1).must_equal 1000
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
  describe 'create_room_block' do
    before do
    end
    it 'creates a block that is stored in reservations' do
    end
    it 'doesnt allow more than 5 rooms per block' do
    end
    it 'only includes rooms that are available when block is made' do
    end
    it 'deals with if there are not enough rooms for the block' do
      # edge case to think about
    end
    it 'doesnt allow general public to reserve a room from the block' do
    end
    it 'doesnt allow rooms to be used for another block' do
    end
  end
  describe 'reserve_room_from_block' do
    it 'allows reservation of a room within a block' do
    end
    it 'doesnt allow reservation within block to have any other date range than blocks' do
    end
  end
  describe 'check_block_room_availibility' do
    it 'returns an array of rooms' do
      available_rooms_in_block.must_be_kind_of Array
    end
    # rest of this method is tested in the block_spec
  end
end

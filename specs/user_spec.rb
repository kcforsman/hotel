require_relative 'spec_helper'
require 'date'

describe 'User' do
  describe 'initialization' do
    before do
      rooms = []
      20.times {|x| rooms << Hotel::Room.new(x+1, 200) }
      @admin = Hotel::User.new(rooms)
    end
    it 'can be initialized' do
      @admin.must_be_instance_of Hotel::User
    end
    it 'has a list of rooms' do
      @admin.must_respond_to :rooms
      @admin.rooms[0].must_be_instance_of Hotel::Room
      @admin.rooms.last.must_be_instance_of Hotel::Room
    end

    it 'wont allow User to initialize with different number of rooms from TOTAL_ROOMS' do
      rooms_1 = []
      rooms_2 = []
      19.times {|x| rooms_1 << Hotel::Room.new(x+1, 200) }
      21.times {|x| rooms_2 << Hotel::Room.new(x+1, 200) }

      proc { Hotel::User.new(rooms_1) }.must_raise StandardError
      proc { Hotel::User.new(rooms_2) }.must_raise StandardError
    end
  end
  describe 'find_available_rooms' do
    before do
      rooms = []
      20.times {|x| rooms << Hotel::Room.new(x+1, 200) }
      @admin = Hotel::User.new(rooms)
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

      available_rooms.wont_include @admin.rooms[0]
      available_rooms.wont_include @admin.rooms[1]
      available_rooms.wont_include @admin.rooms[2]
      available_rooms.wont_include @admin.rooms[3]
      available_rooms.wont_include @admin.rooms[4]
    end
    it 'includes rooms that have same end_date as new start date' do
      reservation1 = @admin.reserve_room(3, "Sam Sole", Date.new(2018,3,1), Date.new(2018,3,30))
      reservation2 = @admin.reserve_room(4, "Alex Whitt", Date.new(2018,3,12), Date.new(2018,3,15))

      available_rooms = @admin.find_available_rooms(@start_date, @end_date)

      available_rooms.wont_include @admin.rooms[2]
      available_rooms.must_include @admin.rooms[3]
    end
  end
  describe 'reserve_room' do
    before do
      rooms = []
      20.times {|x| rooms << Hotel::Room.new(x+1, 200) }
      @admin = Hotel::User.new(rooms)
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
      proc { @admin.reserve_room(5, "Kaeli Smit", Date.new(2018, 3, 25), Date.new(2018, 3, 27)) }.must_be_silent
    end
  end
  describe 'find_reservation_cost' do
    it 'returns cost for reservation with reservation id' do
      rooms = []
      20.times {|x| rooms << Hotel::Room.new(x+1, 200) }
      admin = Hotel::User.new(rooms)
      reservation = admin.reserve_room(5, "Kaeli Poe", Date.new(2018, 3, 20), Date.new(2018, 3, 25))

      admin.find_reservation_cost(reservation.id).must_equal 1000
    end
  end
  describe 'find_reservations_for_given_date' do
    before do
      rooms = []
      20.times {|x| rooms << Hotel::Room.new(x+1, 200) }
      @admin = Hotel::User.new(rooms)
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
      rooms = []
      20.times {|x| rooms << Hotel::Room.new(x+1, 200) }
      @admin = Hotel::User.new(rooms)
      @start_date = Date.new(2018,3,15)
      @end_date = Date.new(2018,3,20)
      @available_rooms = @admin.find_available_rooms(@start_date, @end_date)
    end
    it 'creates a block that is stored in reservations' do
      rooms = @available_rooms.first(5)
      block = @admin.create_room_block(rooms, "Comicon", @start_date, @end_date, 0.2)

      block.must_be_instance_of Hotel::Block
      @admin.find_reservations_for_given_date(@start_date).must_include block
    end
    it 'doesnt allow more than 5 rooms per block' do
      rooms = @available_rooms.first(6)
      proc { @admin.create_room_block(rooms, "Comicon", @start_date, @end_date, 0.2)}.must_raise StandardError
    end
    it 'doesnt allow less than 2 rooms per block' do
      rooms = @available_rooms.first

      proc { @admin.create_room_block(rooms, "Comicon", @start_date, @end_date, 0.2)}.must_raise StandardError
    end
    it 'doesnt allow rooms that are unavailable when block is made' do
      20.times { |x| @admin.reserve_room(x+1, 'Guest #{x+1}', @start_date, @end_date) }
      rooms = @available_rooms.first(5)

      proc {@admin.create_room_block(rooms, "Comicon", @start_date, @end_date, 0.2)}.must_raise StandardError
    end
    it 'deals with if there are not enough rooms for the block' do
      # edge case to think about
      17.times { |x| @admin.reserve_room(x+1, 'Guest #{x+1}', @start_date, @end_date) }
      rooms = @available_rooms.last(5)

      proc {@admin.create_room_block(rooms, "Comicon", @start_date, @end_date, 0.2)}.must_raise StandardError
    end
    it 'doesnt allow rooms to be used for another block or single reservation from general public' do
      rooms = @available_rooms.first(5)
      @admin.create_room_block(rooms, "Comicon", @start_date, @end_date, 0.2)

      proc {@admin.create_room_block(rooms, "Fanime", @start_date, @end_date, 0.2)}.must_raise StandardError
      proc {@admin.reserve_room(rooms.first, "Random Author", @start_date, @end_date)}.must_raise StandardError
    end
  end
  describe 'reserve_room_from_block' do
    before do
      rooms = []
      20.times {|x| rooms << Hotel::Room.new(x+1, 200) }
      @admin = Hotel::User.new(rooms)
      @start_date = Date.new(2018,3,15)
      @end_date = Date.new(2018,3,20)
      @available_rooms = @admin.find_available_rooms(@start_date, @end_date)
      @block = @admin.create_room_block(@available_rooms.first(5), "Comicon", @start_date, @end_date, 0.2)
    end
    it 'returns reservation of a room within a block' do
      room_num = @available_rooms[0].room_num
      reservation = @admin.reserve_room_from_block(@block, room_num, "Spiderman")

      reservation.must_be_instance_of Hotel::Reservation
    end
  end
  describe 'check_block_room_availibility' do
    before do
      rooms = []
      20.times {|x| rooms << Hotel::Room.new(x+1, 200) }
      @admin = Hotel::User.new(rooms)
      @start_date = Date.new(2018,3,15)
      @end_date = Date.new(2018,3,20)
      @available_rooms = @admin.find_available_rooms(@start_date, @end_date)
      @block = @admin.create_room_block(@available_rooms.first(5), "Comicon", @start_date, @end_date, 0.2)
    end
    it 'returns an array of rooms' do
      before_available_rooms_in_block = @admin.check_block_room_availibility(@block)
      room_num = @available_rooms[0].room_num
      reservation = @admin.reserve_room_from_block(@block, room_num, "Spiderman")
      after_available_rooms_in_block = @admin.check_block_room_availibility(@block)

      before_available_rooms_in_block.length.must_equal 5
      before_available_rooms_in_block.must_include @available_rooms[0]
      after_available_rooms_in_block.length.must_equal 4
      after_available_rooms_in_block.wont_include @available_rooms[0]
    end
    # rest of this method is tested in the block_spec
  end
end

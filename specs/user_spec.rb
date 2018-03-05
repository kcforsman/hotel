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
      # hotel_rooms = @admin.rooms

      @admin.must_respond_to :rooms
    end
  end
  xdescribe 'reserve_room' do
    it 'throws StandardError for invalide dates' do
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

require 'date'
require 'pry'

module Hotel
  class Block < User
    attr_reader :id
    def initialize(id, rooms, party, date_range, discount)
      @id = id
      @rooms = rooms
      @party = party
      @date_range = date_range
      @discount = discount
      @reservations = []
    end
  end
end

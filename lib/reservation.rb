require 'date'

module Hotel
  class Reservation
    attr_reader :id, :room_num, :guest, :start_date, :end_date
    def initialize id, room_num, guest, start_date, end_date
      @id = id
      @room_num = room_num
      @guest = guest
      @start_date = start_date
      @end_date = end_date
    end
  end
end

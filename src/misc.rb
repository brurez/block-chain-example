require 'date'

module MicroTime
  def self.now
    DateTime.now.strftime('%Q')
  end
end

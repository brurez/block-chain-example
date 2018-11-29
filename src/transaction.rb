require_relative './misc.rb'

class Transaction
  attr_reader :from, :to, :amount
  def initialize(from, to, amount)
    @from = from
    @to = to
    @amount = amount
    @timestamp = MicroTime.now
  end
end

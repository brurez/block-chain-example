require 'digest'
require_relative './transaction'

class Block
  attr_reader :hash, :previous_hash, :transactions

  def initialize(timestamp, transactions, previous_hash = '')
    @previous_hash = previous_hash
    @timestamp = timestamp
    @transactions = transactions
    @nonce = 0
    @hash = calculate_hash
  end

  def mine(difficulty)
    while @hash[0..difficulty] != '0' * (difficulty + 1)
      @nonce += 1
      @hash = calculate_hash
      puts @hash
    end
  end

  def balance_of(email)
    sum = 0
    @transactions.each do |t|
      if t.to == email
        sum += t.amount
      elsif t.from == email
        sum -= t.amount
      end
    end
    sum
  end

  private

  def calculate_hash
    to_be_hashed = @previous_hash.to_s << @timestamp.to_s << @transactions.to_s << @nonce.to_s
    result = Digest::SHA2.hexdigest to_be_hashed
    result.to_s
  end
end

class BlockChain
  attr_reader :blocks, :pending_transactions

  def initialize
    @blocks = [genesis_block]
    @difficulty = 1
    @pending_transactions = []
    @mine_reward = 100
  end

  def add_transaction(transaction)
    @pending_transactions.push transaction
  end

  def balance_of(email)
    sum = 0
    @blocks.each do |block|
      sum += block.balance_of email
    end

    sum
  end

  def valid?
    @blocks.each_index do |index|
      next if index.zero?
      previous = @blocks[index - 1]
      actual = @blocks[index]
      return false unless previous.hash == actual.previous_hash
    end
    true
  end

  def mine_pending_transactions(reward_address)
    if @pending_transactions.empty?
      puts 'No pending transactions to mine!'
      return
    end
    transaction = Transaction.new(nil, reward_address, @mine_reward)
    @pending_transactions.push transaction

    block = Block.new(MicroTime.now, @pending_transactions, @blocks.last.hash)
    block.mine @difficulty

    puts 'Block successfully mined!'
    @blocks.push block
    @pending_transactions = []
  end

  def length
    @blocks.length
  end

  def last
    @blocks.last
  end

  private

  def genesis_block
    Block.new(Time.new.ctime, [], '0')
  end
end

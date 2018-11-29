require 'rspec'
require_relative './block_chain.rb'

describe BlockChain do
  describe '#add_transaction' do
    it 'adds two transactions' do
      block_chain = BlockChain.new

      t1 = Transaction.new('me@email.com', 'he@email.com', 100)
      t2 = Transaction.new('he@email.com', 'she@email.com', 60)

      block_chain.add_transaction(t1)
      block_chain.add_transaction(t2)
      expect(block_chain.pending_transactions[0]).to eq t1
      expect(block_chain.pending_transactions[1]).to eq t2
    end
  end

  describe '#mine_pending_transactions' do
    it 'mines pending transactions and add to block' do
      block_chain = BlockChain.new

      t1 = Transaction.new('me@email.com', 'he@email.com', 100)
      t2 = Transaction.new('he@email.com', 'she@email.com', 60)

      block_chain.add_transaction(t1)
      block_chain.add_transaction(t2)
      block_chain.mine_pending_transactions('me@email.com')
      expect(block_chain.blocks[1].transactions[0]).to eq t1
      expect(block_chain.blocks[1].transactions[1]).to eq t2
    end
  end

  describe '#last' do
    it 'returns last block of the chain' do
      block_chain = BlockChain.new

      t1 = Transaction.new('me@email.com', 'he@email.com', 100)
      t2 = Transaction.new('he@email.com', 'she@email.com', 60)

      block_chain.add_transaction(t1)
      block_chain.add_transaction(t2)
      block_chain.mine_pending_transactions('me@email.com')
      expect(block_chain.last).to be block_chain.blocks[1]
    end
  end

  describe '#valid?' do
    it 'returns true' do
      block_chain = BlockChain.new

      t1 = Transaction.new('me@email.com', 'he@email.com', 100)
      t2 = Transaction.new('he@email.com', 'she@email.com', 60)

      block_chain.add_transaction(t1)
      block_chain.mine_pending_transactions('me@email.com')
      block_chain.add_transaction(t2)
      block_chain.mine_pending_transactions('she@email.com')

      expect(block_chain.valid?).to be true
    end
  end

  describe '#balance_of' do
    it 'returns the balance of all transactions in the chain' do
      block_chain = BlockChain.new

      t1 = Transaction.new('me@email.com', 'he@email.com', 100)
      t2 = Transaction.new('he@email.com', 'me@email.com', 60)

      block_chain.add_transaction(t1)
      block_chain.add_transaction(t2)
      block_chain.mine_pending_transactions('other@email.com')

      expect(block_chain.balance_of('me@email.com')).to be -40
    end
  end
end

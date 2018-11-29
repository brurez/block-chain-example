#!/usr/bin/env ruby

require './block_chain'
require './transaction'

block_chain = BlockChain.new

t1 = Transaction.new('me@email.com', 'he@email.com', 100)
t2 = Transaction.new('he@email.com', 'she@email.com', 60)

block_chain.add_transaction(t1)
block_chain.add_transaction(t2)
block_chain.mine_pending_transactions('me@email.com')
expect(block_chain.blocks[0]).to be t1
expect(block_chain.blocks[1]).to be t1

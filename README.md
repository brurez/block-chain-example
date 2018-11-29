# Block chain example

Block chain data structure made as an exercise.
Inspired by https://github.com/SavjeeTutorials/SavjeeCoin .

## Try
`ruby src/main.rb`

Type in the console:
```
t1 = Transaction.new('me@email.com', 'he@email.com', 100)
t2 = Transaction.new('he@email.com', 'she@email.com', 60)

block_chain.add_transaction(t1)
block_chain.add_transaction(t2)

block_chain.mine_pending_transactions('me@email.com')

block_chain.balance_of('me@email.com')
```

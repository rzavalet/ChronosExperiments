There are two knobs used in the experiments:

  1) Number of client threads. 
  2) Mode of operation.

For each experiment, we need to capture the following information:
  1) Number of transactions that finish on time
  2) Number of transactions that did not finish on time
  3) Total number of transactions
  4) Response time of all transactions
  5) Slack time of all transactions
  6) Exceeded time of all transactions

From the data above, we will derive the following information:
  1) Success rate, to show how many transactions completed compared to the number of total transactions
  2) Failure rate, to show how many transactions didn't complete compare to the number of total transactions
  3) Number of transactions processed in total in each experiment. 
    a. The rate may be better in one case, however the system may be processing less transactions.
  4) Average response time of all transactions and the distribution.
  5) Average slack time of all transactions and their distribution.
  6) Average jitter of all transactions and their distribution.

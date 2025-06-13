## concepts
- what is a PSP gateway
  - authorization token ? 

# Glossary
- Payment service provider(PSP) like stripe.

# Requirement
- Transaction reconcillation
- Pay-in from customer 
- pay-out to merchants
- Lack of payment
- Duplicate payment
- incorrect payment
- incorrect currency conversion
- Dangling authorization



## Workflows
- user ---> risk engine ---token---> payment authorization service ---token--->
				 | ---token---> payment account			

## Components
 - Order service
   - receives order of products.
 - Payment Account store
   - stores the payment related information like debit card, account info etc.
   - tracks the payment across various states
   - bookkeeping of payments
 - Risk Engines    
   - evaluate the risk of payer based on past payments etc
   - Rejects the ride request incase of notorious riders 
   - prompt user to do pending payments before initiating new ride.
   - generates a payment token before initiating payment
 - payment authorization service
   - interacts with PSP
   
# APIs

# Deep dive
- Integration with PSP.
- Failed transactions
- Exactly-once payment

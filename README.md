# stocker

An App to know crypto rates.
Built using Flutter, Dart, Wit.ai, CoinAPI.

## Getting Started

- Type in a query as you would to to convert crypto to fiat currency or vice versa.
- Stocker uses wit.ai to recognize the crypto and the fiat currency.
- The trained ML model then passes the two string values.
- These values are further passed to CoinAPI to get the rates.
- The rates are then displayed to the user.

### A Few Things To Note

- DO NOT input any symbols.
- DO NOT input any numbers. Stocker can only tell exchange rates.
- Only 100 requests per day can be made as CoinAPI supports only 100 requests per day.
- Speech to Text support coming soon.
- Native iOS app built using Swift coming soon.

#### Examples

- Convert BTC to USD
- What is the value of MCO in GBP
- How is INR doing against ETH

##### API Calls

Wit.ai api call has been made in the function getIntent() in main.dart.
    CoinAPI call has been made in the function getValue() in main.dart.
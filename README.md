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

# Markdown for Hackathon

## Inspiration

As an investor in trading in forex, equities, and cryptocurrencies, I wanted to continuously know the exchange rates of cryptocurrencies against a fiat currency. I wanted to build something for voice assistants such as Alexa or Google Assistant, but I felt like a cross platform mobile application would be more accessible to users.

## What it does

Stocker provides the exchange rates of a cryptocurrency against a fiat currency or vice versa. It takes input in natural language text and provides current exchange rates for the said currencies.

## How I built it

Stocker is built using **Flutter, Dart, Wit.ai, and CoinAPI**.

- The interface is built using Flutter.
- The functionality is done using Dart. packages such as _http, convert, and io_ has been used. These can be found in [link](https://pub.dev/) .
- Wit.ai has been used to process the user input and return the two quotes (crypto and fiat). an API call has been made using the ```http.get``` method.
- The two quotes are passed to CoinAPI and the current rate is returned.

## Challenges I ran into

I tried using Swift for the project but found making the data model for the json file difficult as wit.ai returned the entities in the following manner:
    ```json
    quotes:crypto {
    }
    quotes:currency {
    }
    ````
Following this issue I switched to Flutter using Dart. Then I referenced the json and accessed it using arrays.

## Accomplishments that I'm proud of

Training my own model with such ease. Thanks to the convenience of using wit.ai.

## What I learned

I learned about using multiple APIs and using wit.ai to develop chat bots easily.

## What's next for Stocker

I intend to implement speech to text in the future. I also intend to develop Stocker natively for iOS using Swift.

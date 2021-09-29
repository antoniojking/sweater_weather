# Sweater Weather

https://github.com/antoniojking/sweater_weather


## Project Description
Sweater Weather is an api application, designed with planning road trips in mind. Frontend developers can access the provided endpoints to create weather forecast dashboards, registration and login forms for users, as well as display details for a users next road trip. Additionally, this app will allow users to see the current weather as well as the forecasted weather at the destination when given location parameters.

## Learning Goals
- Expose an API that aggregates data from multiple external APIs
- Expose an API that requires an authentication token
- Expose an API for CRUD functionality
- Determine completion criteria based on the needs of other developers
- Research, select, and consume an API based on your needs as a developer

## Tools Used

| Development | Testing       | Gems            |
|   :----:    |    :----:     |    :----:       |
| Ruby 2.7.2  | RSpec         | Pry             |
| Rails 5.2.5 | WebMock       | ShouldaMatchers |
| PostgresSQL | VCR           | Rubocop         |
| Bcrypt      | SimpleCov     | Figaro          |
| Atom        |               | Faraday         |
| Github      |               |                 |
| Travis      |               |                 |


## Getting Started

Fork and clone the repo at https://github.com/antoniojking/sweater_weather

An api key is generated upon user registration

The `base path` of each endpoint is:

```
https://sweater-weather-2105be.herokuapp.com/api/v1
```

## Endpoints

The following table presents each API endpoint and its parameters.

Endpoint | Docs/Example | Query | JSON Payload
---------|--------------|-------|-------------
Get Forecast for a Destination | GET /api/v1/forecast | location | n/a
Get Images for a Destination | GET /api/v1/backgrounds | location | n/a
Register a New User | POST /api/v1/users | n/a | email, password, password_confirmation
Login a User | POST /api/v1/sessions | n/a | email, password
Create a Road Trip | POST /api/v1/road_trip | n/a | origin, destination, api_key


[contributors-shield]: https://img.shields.io/github/contributors/antoniojking/sweater_weather.svg?style=flat-square
[contributors-url]: https://github.com/antoniojking/sweater_weather/graphs/contributors
[forks-shield]: https://img.shields.io/github/forks/antoniojking/sweater_weather.svg?style=flat-square
[forks-url]: https://github.com/antoniojking/sweater_weather/network/members
[stars-shield]: https://img.shields.io/github/stars/antoniojking/sweater_weather.svg?style=flat-square
[stars-url]: https://github.comantoniojking/sweater_weather/stargazers
[issues-shield]: https://img.shields.io/github/issues/antoniojking/sweater_weather.svg?style=flat-square
[issues-url]: https://github.com/antoniojking/sweater_weather/issues


### <ins>Contributors</ins>

👤  **Antonio King**
- Github: [Antonio King](https://github.com/antoniojking)
- LinkedIn: [Antonio King](https://www.linkedin.com/in/antoniojking/)

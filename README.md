# Tech Stack

- Ruby `3.0.1`
- Database `PostgresSQL`

# Dependencies

For dependencies please checkout the [Gemfile](/Gemfile)

# How to run the application

1. In the project root directory run `bundle install`
2. Once dependencies are installed, add a `.env` file to root directory of your project
3. Copy the content of `.env.example` file and change the content according to your environment
4. Create database with `bundle exec rake db:create`
5. Migrate database with `bundle exec rake db:migrate`
6. Seed database with `bundle exec rake db:seed`
7. Run `bundle exec rackup` to start sever on post `9292`
8. Explore the APIs by importing this PostMan collection

> Link: https://www.getpostman.com/collections/a7f393fe7eaebfc2d136

# Whats Completed

- Created and API service without using frameworks like RoR or Sinatra
- Created all required APIs
- Created Seed to insert 200_000+ rows of data in tables
- Added all necessary validation

# Whats Left

I have created a basic setup of everything, but could not complete the following due to having a very busy work schedule this week.

- Spec for main parts of app
- Cron Job that runs daily at 9:00AM to generate a CSV (or maybe xml, as mentioned in requirement doc) but I have added whenever gem to schedule cron job. 

**Regards**,
### Sajjad Umar
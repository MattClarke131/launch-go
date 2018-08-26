Launch Go
================================================================================
Breakable toy project for Launch Academy Cohort 21
[ ![Launch Go Build Status](https://app.codeship.com/projects/5098d860-7af2-0136-d2cc-1e8efa2619d8/status?branch=master)]

What is go?

http://www.usgo.org/what-go

Stack:
* postgreSQL
* Ruby (2.3.3)
* Rails (5.2)
* React

To create an instance of my app follow these steps:

Clone this repository onto your machine

  `$ git clone https://github.com/MattClarke131/launch-go.git`
  
  
Install required gems with bundle

  `$ bundle install`
  
Install required JS packages with yarn

  `$ yarn install`
  
Make required database migrations

  `$ rake db:create`
  
  `$ rake db:migrate`
  
Start the rails server

  `$ rails s`
  
Start yarn

  `$ yarn start`
  
Visit `localhost:3000/` to see your instance of this app!

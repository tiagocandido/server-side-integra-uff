# Integra UFF

This project is a [Rails](http://rubyonrails.org/) application used to integrate different types of LMS's.

## Dependencies

To run this project you need to have:

* Ruby 2.3.1 - You can use [RVM](http://rvm.io)
* Nokogiri - You can install it from [here](http://www.nokogiri.org/tutorials/installing_nokogiri.html)

## Setup the project

1. Install the dependencies above
2. `$ git clone git@github.com:tiagocandido/server-side-integra-uff.git futebolistica` - Clone the project
3. `$ cd server-side-integra-uff` - Go into the project folder
4. `$ bin/setup` - Run the setup script
5. `$ bin/rspec` - Run the specs to see if everything is working fine

If everything goes well, you can now run the project!

## Running the project

1. `$ bundle exec rails s` - Opens the server
2. Open [http://localhost:3000](http://localhost:3000)

#### Running specs and checking coverage

`$ bundle exec rake spec` to run the specs.

`$ coverage=on bundle exec rake spec` to generate the coverage report then open the file `coverage/index.html` on your browser.

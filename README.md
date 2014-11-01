# Villeme [![Code Climate](https://codeclimate.com/github/asm-products/villeme/badges/gpa.svg)](https://codeclimate.com/github/asm-products/villeme)

Web app helps you to knows everything that is happening and what you can do in your neighborhood.
>John (Jonatas Eduardo)

### Show me something

You can see the software in action in [http://www.villeme.com](villeme.com).

The official repo is https://github.com/asm-products/villeme

## Getting started

### Dependencies

To run this project you need to have:

* Ruby 1.9.3
* Rails 4.0.3
* [PostgreSQL](http://www.postgresql.org/)
	* OSX - [Postgress.app](http://postgresapp.com/)
	* Linux - `$ sudo apt-get install postgresql`
	* Windows - [PostgreSQL for Windows](http://www.postgresql.org/download/windows/)


### Setup the project

* Clone the project

				$ git clone https://github.com/asm-products/villeme.git

* Enter project folder

				$ cd villeme

* Create the `database.yml`

				$ cp config/database.sample.yml config/database.yml

Add your database credentials if necessary.

* Install the gems

				$ bundle install

* Create the database

				$ rake db:create db:migrate

If everything goes OK, you can now run the project!


### Running the project

```bash
$ rails server
```

Open [http://localhost:3000](http://localhost:3000)


## Community of makers

This is a product being built by the Assembly community. You can help push this idea forward by visiting [https://assembly.com/villeme](https://assembly.com/villeme).


### How Assembly community works

Assembly products are like open-source and made with contributions from the community. Assembly handles the boring stuff like hosting, support, financing, legal, etc. Once the product launches we collect the revenue and split the profits amongst the contributors.

Visit [https://assembly.com](https://assembly.com) to learn more.


### I want interact with the project

Go to [https://assembly.com/villeme/bounties](https://assembly.com/villeme/bounties) and do it! :D


## Best practices 

* Make part of Assembly community in [https://assembly.com/villeme](https://assembly.com/villeme)
* Follow this style guide: https://github.com/bbatsov/ruby-style-guide
* Create one acceptance tests for each scenario of the feature you are trying to implement.
* Create model and controller tests to keep 100% of code coverage at least in the new parts that you are writing.


## Team

Founder: Jonatas Eduardo (John) from Brazil.

Team: [https://assembly.com/villeme/people](https://assembly.com/villeme/people)


## License

GNU AFFERO GENERAL PUBLIC LICENSE

Read more on: [https://github.com/asm-products/villeme/blob/master/LICENSE](https://github.com/asm-products/villeme/LICENSE)
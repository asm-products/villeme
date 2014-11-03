# Villeme [![Code Climate](https://codeclimate.com/github/jonatassalgado/villeme/badges/gpa.svg)](https://codeclimate.com/github/jonatassalgado/villeme)

Web app helps you to knows everything that is happening and what you can do in your neighborhood.

### Show me something

You can see the software in action in [villeme.com](http://www.villeme.com).

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

	`$ git clone https://github.com/asm-products/villeme.git`

* Enter project folder
	
	`$ cd villeme`

* Create the *database.yml*

	`$ cp config/database.sample.yml config/database.yml`

Add your database credentials if necessary.

* Install the gems

	`$ bundle install`

* Create the database

	`$ rake db:create db:migrate db:seed`

If everything goes OK, you can now run the project!


### Running the project

	$ rails server

Open [http://localhost:3000](http://localhost:3000)


## Community of makers

This is a product being built by the Assembly community. You can help push this idea forward by visiting [https://assembly.com/villeme](https://assembly.com/villeme).


#### How Assembly community works

Assembly products are like open-source and made with contributions from the community. Assembly handles the boring stuff like hosting, support, financing, legal, etc. Once the product launches we collect the revenue and split the profits amongst the contributors.

Visit [assembly.com](https://assembly.com) to learn more.



## Collaborate with the Villeme community


##### Know the current tasks

Go to [assembly.com/villeme/bounties](https://assembly.com/villeme/bounties) and see the tasks and histories to develop 

##### Tips

The best way to collaborate is to "Fork" repo on GitHub.
This will create a copy of the repo on your GitHub account.

Before you set out to improve the code, you should have a focused idea in mind of what you want to do.

Each commit should do one thing, and each PR should be one specific improvement.

### Forking


	$ git clone



### Editing and Testing


Ok, you're ready to start editing the code, right?
Not quite!
Before you start editing, you should create a *branch*.
A branch is like an alternate timeline.

You can read more about *git branch* [here](http://git-scm.com/book/en/v2/Git-Branching-Branches-in-a-Nutshell).

If you're trying to fix a bug, you might want to name the branch `fix-short-description`.
If you're adding a feature, `feature-short-description` is a good name.

After you can execute checkout to go the branch
`git checkout -b branch-name`


As far as code style, just try to imitate the style of existing code.
Don't sweat over this too much.
If the maintainer doesn't like how your code looks, they'll suggest changes.

You can set of tests to make sure that the existing functionality of the code stays the same as you make changes.
This helps keep the software stable.


#### Committing and Pushing

`git commit -m "your commit message"`

**Using Your Change:** though it may not be obvious, you can begin using your code in your own projects immediately.


## Getting your Change into the Project

You made your change, tested it, committed it with `git commit`, and want to send it back to the project and have it included in a future version.

To do this on GitHub, you need to submit a "pull request" (PR).


### Submitting a Pull Request

The golden rule of submitting PRs is to do things the way the project maintainers would want it done.

You can't read the minds of the project maintainers, but you can look at [assembly.com/villeme/bounties](https://assembly.com/villeme/bounties).


### Submitting a Bug Report (or "Issue")

In GitHub, "Bug Reports" are called "Issues."


- **Has This Been Asked Before?**

Before you submit a bug report, you should search existing issues.
Be sure to check both currently open issues, as well as issues that are already closed.
If you find an issue that seems to be similar to yours, read through it.

If this issue is the same as yours, you can comment with additional information to help the maintainer debug it.
Adding a comment will subscribe you to email notifications, which can be helpful in getting important updates regarding the issue.
If you don't have anything to add but still want to receive email updates, you can click the "watch" button at the bottom of the comments.

- **Nope, Hasn't Been Asked Before**

If you can't find anything in the existing issues, don't be shy about filing a new one.

Project maintainers really appreciate thorough explanations.
It usually helps them address the problem more quickly, so everyone wins!



## Best practices 

* Make part of Assembly community in [assembly.com/villeme](https://assembly.com/villeme)
* Follow this style guide: https://github.com/bbatsov/ruby-style-guide
* Create one acceptance tests for each scenario of the feature you are trying to implement.
* Create model and controller tests to keep 100% of code coverage at least in the new parts that you are writing.


## Team

Founder: [Jonatas Eduardo (John)](https://www.facebook.com/jonataseduardo/) from Brazil.

Team: [assembly.com/villeme/people](https://assembly.com/villeme/people)


## License

GNU AFFERO GENERAL PUBLIC LICENSE

Read more on: [asm-products/villeme/LICENSE](https://github.com/asm-products/villeme/blob/master/LICENSE)
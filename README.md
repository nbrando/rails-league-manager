## Installation

### Requirements

- Ubuntu 24.04
- Ruby 3.4.9
- Rails 8.1.3
- PostgreSQL 16

Instructions for installing Ruby and Rails can be found on their website:
https://guides.rubyonrails.org/install_ruby_on_rails.html

PostgreSQL can be installed and run with these commands:

```bash
sudo apt install postgresql
sudo service postgresql start
sudo -u postgres createuser <your username> -s
```

### Setup

Clone the repo (or don't if you've got the files from Canvas):

```bash
git clone 
cd league_manager
```

Install Ruby dependencies:

```bash
bundle install
```

Create and seed the database:

```bash
bin/rails db:setup
```

Run the server:

```bash
bin/rails server
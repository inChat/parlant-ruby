# Parlant Ruby Client
:warning: **WIP: This is a work in progress.**

A Ruby client library for interacting with the [Parlant API](https://www.parlant.io/docs).

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'parlant-ruby'
```

And then execute:

```bash
$ bundle install
```

Or install it yourself as:

```bash
$ gem install parlant-ruby
```

## Usage

### Configuration

```ruby
require 'parlant-ruby'

# Configure the client globally
Parlant.configure do |config|
  config.api_key = 'your-api-key'
  config.base_url = 'https://api.parlant.io' # Optional, defaults to this value
end

# Or create a client instance with specific configuration
client = Parlant::Client.new(api_key: 'your-api-key')
```

### Working with Agents

```ruby
# List all agents
agents = client.agents.list

# Create a new agent
agent = client.agents.create(name: 'My Agent', description: 'This is my agent')

# Get an agent by ID
agent = client.agents.get('agent-id')

# Update an agent
agent = client.agents.update('agent-id', name: 'Updated Agent Name')

# Delete an agent
client.agents.delete('agent-id')
```

### Working with Customers

```ruby
# List all customers
customers = client.customers.list

# Create a new customer
customer = client.customers.create(name: 'John Doe')

# Get a customer by ID
customer = client.customers.get('customer-id')

# Update a customer
customer = client.customers.update('customer-id', name: 'Jane Doe')

# Delete a customer
client.customers.delete('customer-id')
```

### Working with Sessions

```ruby
# List all sessions
sessions = client.sessions.list

# Create a new session
session = client.sessions.create(
  agent_id: 'agent-id',
  customer_id: 'customer-id'
)

# Get a session by ID
session = client.sessions.get('session-id')

# Update a session
session = client.sessions.update('session-id', status: 'completed')

# Delete a session
client.sessions.delete('session-id')
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `bundle exec rspec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/inchat/parlant-ruby.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

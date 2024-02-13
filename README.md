# codewars-exporter

[![Ruby Style Guide](https://img.shields.io/badge/code_style-rubocop-brightgreen.svg)](https://github.com/rubocop/rubocop)

codewars-exporter is a prototype application which parse solutions from [codewars.com](https://www.codewars.com/dashboard) to local file. You can optionally choose languages and save methods.

# api

https://dev.codewars.com/

# Functionality

1. Check main info about profile
2. Parse all solutions to one file
3. Save solution per file
4. Choosing language which to be parsed

# Requirements

1. Pretty good if you have installed ruby <3
2. Email and password from codewars (any other methods to login like Oauth doesnt worked)

# Usage

#### 0. You have to install web-driver for your browser (we are using chrome by default)

```
http://watir.com/guides/drivers/
```

#### 1. Setup application:

```ruby
bundle install
```

#### 2. For using codewars-api (general information) functionality you should use:

```ruby
bin/api <email> <password>
```

#### 3. If you want to parse your solutions just use:

```ruby
bin/parser <email> <password> <choice_method>
```

### Choice methods

1. Save every solution to every file
2. Save all solutions to one file

Anyway all params can be blank and you will need put them later

# Contribution

1. Select issue and write comment like: "I want to take the issue"
2. Wait my answer
3. Fork the repository, create branch with issue name
4. When task is complete - create pull request and tell me about status of task

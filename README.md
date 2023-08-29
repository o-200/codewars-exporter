# codewars-exporter

[![Ruby Style Guide](https://img.shields.io/badge/code_style-rubocop-brightgreen.svg)](https://github.com/rubocop/rubocop)

Main idea is to parse all solutions to one file for uploading them to github

api - https://dev.codewars.com/

# Functionality

1. Check main info about profile
2. Parse all solutions to one file
3. Save solution per file
4. Choosing language which to be parsed

# Requirements
```
Pretty good if you installed ruby <3
```

# Usage
#### 1. setup application.
```ruby
bundle install
```

#### 2. For using codewars-api (general information) functionality you should use:
```ruby
bin/api <email> <password>
```

#### 3. If you want to parse your solutions just use:
```ruby
bin/parser <email> <password>
```

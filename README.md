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
```
Pretty good if you installed ruby <3
You can use application only with email and password from codewars (any other methods to login like Oauth doesnt worked)
```

# Usage
#### 1. build docker image.
```bash
docker build -t codewars-exporter .
```

#### 2. run docker container.
```bash
docker run -itv ~/Projects/codewars-exporter:/codewars-exporter codewars-exporter bash
```

#### 3. For using codewars-api (general information) functionality you should use:
```ruby
bin/api <email> <password>
```

#### 4. If you want to parse your solutions just use:
```ruby
bin/parser <email> <password>
```

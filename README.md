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

1. Docker

# Usage

#### 0. Install Docker if you don't have them

#### 1. Install Project From Github

#### 2. Build Image
`docker build -t codewars-exporter .`

#### 3. Start Image bash
`docker run -it codewars-exporter /bin/sh`

#### 4. Use Our functionality
If you're rubyist you can check bin/* for any configs, but anyway use

- use info from codewars api - `bin/api <email> <password>`
- debugging - `bin/console`
- parse solutions - `bin/parser <email> <password> <choice methods> <language>`

P.S: choice methods and language parameters must be blank. (not anymore because docker)

### Choice methods

1. Save every solution to every file
2. Save all solutions to one file

Anyway all params can be blank and you will need put them later

# Contribution

1. Select issue and write comment like: "I want to take the issue"
2. Wait my answer
3. Fork the repository, create branch with issue name
4. When task is complete - create pull request and tell me about status of task

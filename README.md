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

## Using docker
1. Docker

## Local install
1. geckodriver (https://github.com/mozilla/geckodriver)
2. firefox-esr (https://www.mozilla.org/en-US/firefox/enterprise/)

# Usage

## Using Docker:

#### 1. Install Project 
#### 2. Build Image
`docker build -t codewars-exporter .`
#### 3. Start Image bash
`docker run -it codewars-exporter /bin/sh`
#### 4. Use Our functionality

## Locall installation:

#### 1. Install Project 
#### 2. Install require dependencies above
##### 2.1 For geckodriver you should unpack acrhive and rename unpacked file to ```geckodriver```
#### 3. ```bundle install```
#### 4. Use Our functionality


# Functionality:
If you're rubyist check bin/* for any configs, if isnt:

- print info from codewars api - `bin/api <email> <password>`
- parse solutions - `bin/parser <email> <password> <choice methods> <language>`

### Choice methods - must be integer

1. Save every solution to every file
2. Save all solutions to one text file

#### Example of requests:

1. bin/api myemail@email.com mypassword
2. bin/parser myemail@email.com mypassword 1 ruby

# Contribution

1. Select issue and write comment like: "I want to take the issue"
2. Wait my answer
3. Fork the repository, create branch with issue name
4. When task is complete - create pull request and tell me about status of task

If you needed for feature - create issue and let's discuss!

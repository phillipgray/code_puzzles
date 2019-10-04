# Quickstart Guide

## Bootstrappin'
- Prerequisites: Unix system with git and Ruby (tested with 2.5; though >2.0 should work) installed
- Clone the repo
- You're ready to go!

## Running the code
- The main interface is in `account_number_file.rb`.
- The easiest way to interact with the code is to load it into an interactive ruby session (irb).
  - Navigate to the `bank_ocr` project folder in your terminal of choice.
  - Run irb with the needed files loaded, enter `irb -r ./account_number_file.rb`.
- At the prompt, load your file with account numbers by passing a filepath as a string to the `parse` method on `AccountNumberFile`
  - `file = AccountNumberFile.parse("path/to/file")`
- This AccountNumberFile instance has a single output method, `write`.
  - If given no arguments, `file.write` will print a summary of account numbers and any related error codes in the console.
  - Otherwise, the `write` method can take a filepath as a string to specify where you would like a summmary text file to be generated, e.g. `file.write(path/to/output_file)`.
- When finished, exit the interactive ruby session with `exit`

## Running the specs (if you'd like)
- If you don't already have RSpec installed, run `bundle install` in the console while in the project root folder.
- Then run tests with `bundle exec rspec spec`

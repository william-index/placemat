[![Code Climate](https://codeclimate.com/github/william-index/placemat/badges/gpa.svg)](https://codeclimate.com/github/william-index/placemat)
[![Gem Version](https://badge.fury.io/rb/placemat.svg)](http://badge.fury.io/rb/placemat)
# Placemat

Placemat is a robust (maybe?) pre-processing language exclusively for HTML tables.

As of V 0.1.0, Placemat can handle parsing of basic tables without attribute formatting on cells.

## Installation

You can install this gem:

    $ gem install placemat

## Usage

### Running Placemat
Placemat runs from the terminal after installation, by simply pointing to a .plmat file. It will render an html version of that file in the working directory. the
  -c
argument passes the file name to render.

```
cd dir
placemat -c myfile.plmat
```

### Placemat Documents

#### File Types
Placemat is an evolving file format. In the current build it is able to handle a small subset of commands. Placemat takes in .plmat files and outputs .html

In each .plmat file, multiple html tables can be rendered. Each unique table is denoted by a line in-between it and the previous

```
table

table
```

Cells (tr and td) are seperated on each row using a pipe (|)

```
First Name | Last Name | Email
Scrooge    | McDuck    | number1dime@example.net
Launchpad  | McQuack   | lpad@example.org
```

Similar to github flavored markdown, header cells are anything in a table located above a line of (in Placemat format) pure hyphens

```
First Name | Last Name | Email
------------------------------------------------
Scrooge    | McDuck    | number1dime@example.net
Launchpad  | McQuack   | lpad@example.org
```

Unlike other table formatting languages Placemat allows for comments.  
Comments are either a full line, or in line and begin with a semi-colon (;)

```
First Name | Last Name | Email
------------------------------------------------
Scrooge    | McDuck    | number1dime@example.net ; Email should be @moneybin, but that was taken
Launchpad  | McQuack   | lpad@example.org
```

As tables can get complex, Placemat supports some alternative formatting methods as well. Any line that begins with a tab counts as an extension of the previous line, so the table above can be rewritten as the following if desired:

```
First Name
  | Last Name
  | Email
  ; This is the header row
---
Scrooge
  | McDuck
  | number1dime@example.net
  ; Email should be @moneybin, but that was taken
Launchpad  
  | McQuack
  | lpad@example.org
```

These styles can be mixed within the same file or even table if desired

#### Cell Arguments
Each cell can take a number of arguments as well. An argument block in Placemat begins with a double colon (::), multiple arguments are separated with an ampersand (&).

**X**
The X argument denotes a cell that should not render, this is used primarily for formatting and will be more useful when colspan and rowspan are incorporated

```
A|B|C
-----
1|this cell wont show ::X|2|3

```


## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release` to create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

1. Fork it ( https://github.com/william-index/placemat/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

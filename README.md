# Photo Data Parser

## Description

A code challenge for Heartland. This is a stateless utility class written in Ruby. It's main function is to rename photos.
Given a string representing the list of `M` photos, it returns the string representing the list of the new names of all photos (the order of photos will stay the same).

Assumptions:

- `M` is an integer within the range (1..100);
- Each year is an integer within the range (2000..2020);
- Each line of the input string is of the format '<\<photoname>>.<\<extension>>, <<city_name>>, yyyy-mm-dd hh:mm:ss' and lines are separated with newline characters;
- Each photo name (without extension) and city name
  name consists only of at least 1 and at most 20 letters from the English alphabet;
- Each name of the city starts with a capital letters and is followed by lower case letters;
- No two photos from the same location share the same date and time;
- Each extension is "jpg", "png" or "jpeg".

For example, given a string:

```
"photo.jpg, Krakow, 2013-09-05 14:08:15
Mike.png, London, 2015-06-20 15:13:22
myFriends.png, Krakow, 2013-09-05 14:07:13
Eiffel.jpg, Florianopolis, 2015-07-23 08:03:02
pisatower.jpg, Florianopolis, 2015-07-22 23:59:59
BOB.jpg, London, 2015-08-05 00:02:03
notredame.png, Florianopolis, 2015-09-01 12:00:00
me.jpg, Krakow, 2013-09-06 15:40:22
a.png, Krakow, 2016-02-13 13:33:50
b.jpg, Krakow, 2016-01-02 15:12:22
c.jpg, Krakow, 2016-01-02 14:34:30
d.jpg, Krakow, 2016-01-02 15:15:01
e.png, Krakow, 2016-01-02 09:49:09
f.png, Krakow, 2016-01-02 10:55:32
g.jpg, Krakow, 2016-02-29 22:13:11"
```

The function should return:

```
Krakow02.jpg
London1.png
Krakow01.png
Florianopolis2.jpg
Florianopolis1.jpg
London2.jpg
Florianopolis3.png
Krakow03.jpg
Krakow09.png
Krakow07.jpg
Krakow06.jpg
Krakow08.jpg
Krakow04.png
Krakow05.png
Krakow10.jpg
```

## Installation

To install and run this project, follow these steps:

### Prerequisites

Ensure you have Ruby installed on your system. This project requires Ruby version [3.2.2]. You can check your Ruby version by running:

```bash
ruby --version
```

If you need to install Ruby, follow the instructions on the [official Ruby website](https://www.ruby-lang.org/en/documentation/installation/).

### Clone the Repository

First, clone the repository to your local machine:

```
git clone https://github.com/acasarsa/heartland_code_challenge.git
cd heartland_code_challenge
```

### Install Dependencies

This project uses Bundler to manage its dependencies. Install Bundler (if you haven't already) and then install the project dependencies:

```bash
gem install bundler
bundle install
```

### Run the Application with mock data

This will run the application using the supplied data from the code challenge and print the results to the console.

```bash
ruby run_with_mock_data.rb
```

## Running Tests

To run tests with Rspec. There should be 4 test examples.

```
rspec
```

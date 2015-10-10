# remarkovable

A gem that produces Markov chain output from any text.

Stuff like this:

>""Wholesome exercise and pure air of the nature of the Roman Empire should be captive so as to who may be as long as you gazed, and wondered what monstrous cannibal and savage could ever have gone from bad to worse."  *The Prince* + *Moby Dick*


Mix up the source material for more interesting output!

## Setup

Add this to your Gemfile:

```
gem 'remarkovable', git: 'https://github.com/jwworth/remarkovable'
```

## Features

### Basic

Initiate a new Markov engine, and make it speak:

```ruby
r = Remarkovable.new(string: File.read('the-prince.txt'))
r.speak
```

Sample output:

>"The barbarity of this they did not move forward, and trampled each other and their own ability and not by wickedness or any other town in the Val di Nievole, therefore he did not succeed."

### Prefix Length

The prefix length defaults to `2`. Lower it for less coherent output:

```ruby
r = Remarkovable.new(string: File.read('the-prince.txt'), prefix_length: 1)
r.speak
```

Sample output:

>"Reply delighted was everybody and who, in at it the that that of soldiers state, that they and within a for Milan, the affairs, have."

Raise it for more coherent output:

```ruby
r = Remarkovable.new(string: File.read('the-prince.txt'), prefix_length: 5)
r.speak
```

Sample output:

>"For, provided it is well known that he with against THAT."

### Custom Key

Set a custom starting key (case sensitive for more specific results):

```ruby
r = Remarkovable.new(string: File.read('the-prince.txt'))
r.speak(custom_key: 'we are')
```

Sample output:

>"We are concerned with those who had remained with his friends and retainers; and he was taken from ancient and modern affairs, we shall find that it would be liable to from the Pope."

If there is no match, a key will be chosen randomly.

### License

&copy; 2015 Jake Worth

This repository is distributed under the MIT license. See `LICENSE` for
details.


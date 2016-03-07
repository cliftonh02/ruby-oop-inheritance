# Intermediate Object-Oriented Programming in Ruby

See also: https://github.com/ga-wdi-lessons/ruby-oop

## Learning Objectives

- Explain the use of self in Ruby
- Explain the difference between local, instance and class variables
- Define and differentiate between class and instance methods
- Define inheritance in the context of OOP
- Write a Ruby class that inherits from another

## `self` in ruby

In ruby, self is very similar to `this` in Javascript, it refers to the object
the method was called on. Thankfully, however, it's much simpler in Ruby...
because methods can't be called without context (i.e. no callbacks), there's no
`bind` to worry about, `self` always equals the thing the method was called on.

### Exercise on `self` (15 minutes)

Pair up and consider the following example, specifically the `demonstrate_using_self`
method. Talk with your partner for 7 minutes and discuss what effect each line
will have, and which one is the best.

Feel free to run this code and play with it.

```ruby
# person/self.rb
class Person
  attr_accessor :name
  attr_reader :hunger_level

  def initialize(initial_name, initial_hunger_level)
    @name = initial_name
    @hunger_level = initial_hunger_level
  end

  def hunger_level=(new_hunger_level)
    if new_hunger_level < 0
      @hunger_level = 0
    else
      @hunger_level = new_hunger_level
    end
  end

  def demonstrate_using_self
    # goal is to get our person's name in the best way possible
    # GETTERS
      puts @name
      puts name
      puts self.name

    # goal is to set/update our person's hunger level in the best way possible
    # SETTERS
      @hunger_level = -10
      hunger_level = -10
      self.hunger_level = -10
  end
end
```

You can find the answers in [this file](examples/person/self.rb).

To sum up:
1. Always use getter/setter methods inside the class instead of instance variables.
  * exception: you can use instance variables inside getter / setter methods themselves
2. To call a *getter* method inside a class, self is optional, e.g. both `self.name` AND `name` works
3. To call a *setter* method inside a class, you MUST use self, e.g. `self.color = red`

## Class vs Instance Review (5 minutes)

It's important to reiterate the difference between the class, and instances
created from that class:

* A class' name is capitalized , e.g. `Person`, and is a template for objects of that class.
* An instance is one specific object created using a class, e.g. `bob = Person.new("Bob", 10)`


## Class vs Instance Methods and Variables (10 minutes)

### Class vs Instance vs Local Variables

Local variables:
  * plain vanilla names, e.g. `current_age`, `favorite_color`
  * only valid in the current method (limited scope)
  * used for temporary values in a class

Instance variables:
  * start with an `@`, e.g. `@name`
  * each instance gets it's own copy (used to store properties/attributes)
  * can be used in any instance method in the class
  * very common in ruby

Class Vars:
  * start with 2 `@`s, e.g `@@person_count`
  * one copy shared between all instances
  * **not very common**, over-use is considered bad practice

### Class vs Instance Methods
Ruby classes can define two types of methods, *instance* and *class* methods. So
far, we've only written instance methods.

* *instance methods* - called on on single instances
* *class methods* - called on the class, deal with the set of objects.

**Examples**

* Instance
  * `jill.speak`
  * `jill.age = 41`
  * `bob.speak`
  * `ferrari.start`
  * `gorilla.eat("banana")`
* Class
  * `Person.new`
  * `Monkey.new`
  * `Monkey.feed_all("banana")`

Instance and Class methods are both common, and ok to use (unlike class
variables, which should be used sparingly).

### Defining class vs instance methods

```ruby
# person6.rb: person_count
# from irb:
#   load "examples/person/person6.rb"

class Person
  attr_accessor :name
  @@person_count = 0 # class variable

  def initialize(initial_name)
    @@person_count += 1
    @name = initial_name
  end

  # instance method, just like we've seen before
  def introduction
    puts "Hello, I'm #{name}, one of #{Person.person_count} people"
  end

  # class method, notice the `self` in the definition, which refers to the
  # Person class
  def self.person_count
    return @@person_count
  end
end

Person.person_count   #=> 0
jill = Person.new("Jill")
Person.person_count   #=> 1
bob = Person.new("Bob")
Person.person_count   #=> 2
```

### You Do

- add support for `matt.person_count`
- add support for asking if a person is old enough to vote.

### Code Walkthrough(10 minutes)

**[Application Config Class in Ruby](https://github.com/ga-dc/ruby_application_configuration)**

### Turn & Talk (5 minutes)

3 minutes to discuss:

Questions
---
* Can we use instance variables in class methods?
* Can we use class variables in an instance method?
* Can we call instance methods in class methods?
* Can we call class methods inside an instance method?


> Answers:
* No, ruby wouldn't know which instance's value to use.
* Yes, the one copy is shared, and all instances can access.
* No, again, instance methods depend on being called on a specific instance,
  class wouldn't know which to choose.
* Yes, the method is shared, and can be used by all instances.


## Inheritance

Just like we get traits from our parents, we can use a feature called
**inheritance** to create multiple classes (children) that share properties and
methods from their parents.

You won't need to write parent / child classes much in this class, but we will
use inheritance to give some of our classes additional functionality, especially
with rails in a few weeks.

Here's an example:
```ruby
# person7.rb: inheritance

class Person
  attr_accessor :name
  attr_reader :hunger_level

  def initialize(initial_name, initial_hunger_level)
    @name = initial_name
    @hunger_level = initial_hunger_level
  end

  def introduction
    puts "Hello, I'm #{name}"
  end

  # Custom setter for hunger_level
  def hunger_level=(new_hunger_level)
    if new_hunger_level < 0
      @hunger_level = 0
    else
      @hunger_level = new_hunger_level
    end
  end

end

class LoudPerson < Person
  def introduction
    puts "HELLO, I'M #{name.upcase}!!"
  end
end

jill = Person.new("Jill", 10)
bob = LoudPerson.new("Bob", 10)

puts jill.introduction
puts

puts bob.introduction

puts "Bob's name: '#{bob.name}'"
bob.hunger_level = 5
puts "Bob hunger level: #{bob.hunger_level}"
```

### You Do: Inheritance

- Make a sleepy person, who sleeps through the introduction.
- Make a baby, who can only say "Dada" and is always hungry (hunger_level never reaches 0)



## Visibility

When discussing object-oriented programming, you may hear the term "visibility".  This refers to the availability, or scope, of a method. Who can call this method on the object?

- Public: any one can call this method.  Public is default accessibility level for class methods.
- Private and Protected: (not common) Not visible to other objects from other classes.  Control visibility to other instances of that Class, including descendants.


## Sample Questions

- Explain the use of self in Ruby
- Explain the difference between local, instance and class variables
- Define and differentiate between class and instance methods
-

## Vocabulary

* **class**: an object blueprint
* **instance**: a constructed class instance
* **sub-class**: a class derived through inheritance.
* **extends**: a class is "extended" into a sub-class.
* **self**: an instance's way of referring to itself.
* **super**: a sub-class' way of referring to its parent class.
* **public**: methods available outside of the class.
* **private**: methods available only within the class.
* **protected**: methods available to only the class and its descendants.

## Resources

- Visibility http://stackoverflow.com/questions/9882754/what-are-the-differences-between-private-public-and-protected-methods
- Private/Protected http://matthodan.com/2010/08/08/ruby-private-methods-vs-protected-methods.html

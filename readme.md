# Intermediate Object-Oriented Programming in Ruby

See also: https://github.com/ga-wdi-lessons/ruby-oop

## Learning Objectives

- Explain the use of self in Ruby
- Explain the difference between local, instance and class variables
- Define and differentiate between class and instance methods
- Define inheritance in the context of OOP
- Write a Ruby class that inherits from another

## Framing

Today you started to learn about object-oriented programming in Ruby and how we can use classes to create a blueprint for objects containing related attributes and methods. Like constructor functions in Javascript, we can then use classes and the `.new` method to produce instances of these objects.

This afternoon we're going to continue diving intro OOP in Ruby. In particular, we'll be taking a look at **inheritance** and how we can pass attributes and methods between classes.

But first, let's review and build upon some of the concepts that were introduced this morning...

## We Do: Let's Build A Class

Let's create a `Person` class together...

<details>
  <summary><strong>How do we begin defining a <code>Person</code> class?</strong></summary>

  ```rb
  class Person
  end
  ```

</details>

--------

<details>
  <summary><strong>How can we set up our Person class so that it has <code>name</code> and <code>age</code> attributes. We should be able to read and modify <code>name</code>, but only read <code>age</code>.</strong></summary>

  ```rb
  class Person
    # This allows us to both read and write to the name and hunger_level attributes
    attr_accessor :name
    attr_reader :age

    # This is run every time we call Person.new
    # Think of it as a "constructor method"
    def initialize(initial_name, initial_age)
      @name = initial_name
      @age = initial_age
    end
  end

  adrian = Person.new("Adrian", 29)

  adrian.name
  # => "Adrian"
  adrian.name = "Dwayne 'The Rock' Johnson"
  adrian.name
  # =>"Dwayne 'The Rock' Johnson"

  adrian.age
  # => 29
  adrian.age = 1
  # => undefined method `age='
  ```

  > In place of the `attr` methods, we could also define getter and setter methods.

</details>

--------

<details>
  <summary><strong>Let's give our <code>Person</code> class a <code>say_name</code> method that prints his/her name to the console.</strong></summary>

  ```rb
  class Person
    attr_accessor :name
    attr_reader :age

    def initialize(initial_name, initial_age)
      @name = initial_name
      @age = initial_age
    end

    def say_name
      puts "Hi, my name is " + @name + "."
    end
  end

  adrian = Person.new("Adrian", 29)
  adrian.say_name
  # => "Hi, my name is Adrian."
  ```

  > We could also use `self.name` in place of the instance variable `@name`. This is actually preferable. We'll explain why later...

</details>

--------

<details>
  <summary><strong>Now we want to keep track of how many people have been created using the <code>Person</code> class. What tools can we use to do this? How would we use them?</strong></summary>

  ```rb
  class Person
    attr_accessor :name
    attr_reader :age
    # We create a class variable to keep track of how many people have been created.
    @@people = 0

    def initialize(initial_name, initial_age)
      @name = initial_name
      @age = initial_age
      # Whenever we create a new person, we want to increment `@@people`
      @@people += 1
    end

    def say_name
      puts "Hi, my name is " + @name + "."
    end

    # Here we're creating a method that retrieves the value of `@@people`
    def self.get_people
      return @@people
    end
  end

  adrian = Person.new("Adrian", 29)
  puts adrian.get_number_of_people
  # => error
  puts Person.get_number_of_people
  # => 1

  keith = Person.new("Keith", 100)
  puts Person.get_number_of_people
  # => 2
  ```

  > We could also use `self.name` in place of the instance variable `@name`. This is actually preferable. We'll explain why later...

</details>

### Classes vs. Instances

It's important to reiterate the difference between the class and instances
created from that class.
* A class' name is capitalized (e.g., `Person`) and is a template for objects of that class.
* An instance is one specific object created using a class (e.g. `bob = Person.new("Bob", 10)`).

### Variables: Class vs. Instance vs. Local

#### Local
* Written using plain vanilla names (e.g., `current_age`, `favorite_color`).
* Limited in scope. Only accessible in the current method.
* Used for temporary values in a class.

#### Instance
* Start with an `@` (e.g., `@name`).
* Used to store attributes for a given instance.
* Can be used in any instance method in the class.
* Very common in ruby.

#### Class
* Start with 2 `@`s (e.g., `@@person_count`).
* One copy shared between all instances.
* Not very common. Over-use is considered bad practice.

### Methods: Class vs. Instance

Ruby classes can define two types of methods...
* Instance: called on on single instances.
* Class: called on the class, deal with the set of objects.

Instance and Class methods are both common, and okay to use. This is unlike class variables, which should be used sparingly.

### Turn & Talk (5 minutes)

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

## Refactoring our Person class with `self`

### What is `self`?

<details>
  <summary><strong>Q: What does `self` mean in Ruby?</strong></summary>

  > It contains the current instance of an object.

</details>

<details>
  <summary><strong>Q: What is the equivalent of `self` in Javascript?</strong></summary>

  > `this`

</details>

One benefit on Ruby is that it is much easier to determine what context we are working in. Unlike Javascript, we cannot redefine what context we are working with using methods like `.bind` `.call` or `.apply`.

### Exercise on `self` (15 minutes)

Consider the below `Person` class. In both the `get_name` and `set_hunger_level` instance methods, we have written three ways to reference attributes stored in a class.

With a partner, consider the following questions for each attribute reference...
* Does it successfully get/set the value?
* If it does, do you think it is the best way to do get/set that attribute?

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

  def get_name
    # goal is to get our person's name in the best way possible
    puts @name
    puts name
    puts self.name
  end

  def set_hunger_level
    # goal is to set/update our person's hunger level in the best way possible
    @hunger_level = -10
    hunger_level = -10
    self.hunger_level = -10
  end
end
```

> You can find the answers in [this file](examples/person/self.rb).

To sum up:
1. Always use getter/setter methods inside the class instead of instance variables.
  * exception: you can use instance variables inside getter / setter methods themselves
2. To call a *getter* method inside a class, self is optional, e.g. both `self.name` AND `name` works
3. To call a *setter* method inside a class, you MUST use self, e.g. `self.color = red`

### You Do: Keep Building `Person`

Make the following additions to our `Person` class...

* Add support for `adrian.person_count`
* Add support for asking if a person is old enough to vote.

### Code Walkthrough (10 minutes)

**[Application Config Class in Ruby](https://github.com/ga-dc/ruby_application_configuration)**

## Break

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

* Make a sleepy person, who sleeps through the introduction.
* Make a baby, who can only say "Dada" and is always hungry (hunger_level never reaches 0)

### You Do: Superheroes

Clone down [this repo](https://github.com/ga-wdi-exercises/superheros) and follow the instructions in the readme.


## Visibility

When discussing object-oriented programming, you may hear the term "visibility".  This refers to the availability, or scope, of a method. Who can call this method on the object?

- Public: any one can call this method.  Public is default accessibility level for class methods.
- Private and Protected: (not common) Not visible to other objects from other classes.  Control visibility to other instances of that Class, including descendants.


## Sample Questions

* Explain the use of self in Ruby.
* Explain the difference between local, instance and class variables.
* Define and differentiate between class and instance methods.

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

* [Getters and Setters](http://andrewsunglaekim.github.io/Get-set-ruby/)
* [Visibility](http://stackoverflow.com/questions/9882754/what-are-the-differences-between-private-public-and-protected-methods)
* [Private/Protected](http://matthodan.com/2010/08/08/ruby-private-methods-vs-protected-methods.html)

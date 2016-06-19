# Intermediate Object-Oriented Programming in Ruby

## Learning Objectives

- Explain the use of self in Ruby
- Explain the difference between local, instance and class variables
- Define and differentiate between class and instance methods
- Define inheritance in the context of OOP
- Write a Ruby class that inherits from another

## Framing

[This morning](https://github.com/ga-wdi-lessons/ruby-oop) you started to learn about object-oriented programming in Ruby and how we can use classes to create a blueprint for objects containing related attributes and methods. Like constructor functions in Javascript, we can then use classes and the `.new` method to produce instances of these objects.

This afternoon we're going to continue diving intro OOP in Ruby. In particular, we'll be taking a look at **inheritance** and how we can pass attributes and methods between classes.

But first, let's review and build upon some of the concepts that were introduced this morning...

## We Do: Let's Build A Class

Let's create a `Person` class...

--------

<details>
  <summary><strong>Q: What's the difference between a class and an instance?</strong></summary>
  <br/>

  A class is a blueprint. An instance is an object generated from that blueprint.
  * A class' name is capitalized (e.g., `Person`) and is a template for objects of that class.
  * An instance is one specific object created using a class (e.g. `bob = Person.new("Bob", 10)`).
</details>
<br/>
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
  ```

  > In place of the `attr` methods, we could also define getter and setter methods.

</details>
<br/>
<details>
  <summary><strong>Q: Why did we place an <code>@</code> in front of our variables? How else could we have written our variables?</strong></summary>
  <br/>

  `@` indicates that we are defining an instance variable, which is a value that is accessible anywhere inside a given instance of a class.

  The different types of variables we can use are...

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

</details>
<br/>
<details>
  <summary><strong>How can we generate an instance of this <code>Person</code> class?</strong></summary>

  ```rb
  adrian = Person.new("Adrian", 29)
  ```
</details>
<br/>
<details>
  <summary><strong>How do we go about accessing/modifying a <code>Person</code> instance's <code>name</code> and <code>age</code> attributes?</strong></summary>

  ```rb
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

<details>
  <summary><strong>What type of method is <code>say_name</code>? What other types of methods are there?</strong></summary>

  `say_name` is an instance method. It is a method that we would call on an instance of `Person`.

  Ruby classes can define two types of methods...
  * **Instance:** called on on single instances.
  * **Class:** called on the class, deal with the set of objects.

  Instance and Class methods are both common and okay to use. This is unlike class variables, which should be used sparingly.

</details>

--------

<details>
  <summary><strong>Now we want to keep track of how many people have been created using the <code>Person</code> class. What tools can we use to do this? How would we use them?</strong></summary>

  ```rb
  class Person
    attr_accessor :name
    attr_reader :age
    # We create a class variable that is an array contains all existing instances of `Person`
    @@people = []

    def initialize(initial_name, initial_age)
      @name = initial_name
      @age = initial_age
      # Whenever we create a new person, we push it into the `@@people` array
      @@people.push(self)
    end

    def say_name
      puts "Hi, my name is " + @name + "."
    end

    # Here we're creating a method that retrieves the value of `@@people`
    def Person.get_people
      return @@people
    end
  end

  adrian = Person.new("Adrian", 29)
  puts adrian.get_people
  # => error
  puts Person.get_people
  # => 1

  keith = Person.new("Keith", 100)
  puts Person.get_people
  # => 2
  ```

  > We could also use `self.name` in place of the instance variable `@name`. This is actually preferable. We'll explain why later...

</details>

### Turn & Talk

Answer the following questions with a partner...

<details>
  <summary><strong>Can we use instance variables in class methods?</strong></summary>

  > No, ruby wouldn't know which instance's value to use.

</details>
<br/>
<details>
  <summary><strong>Can we use class variables in an instance method?</strong></summary>

  > Yes, the one copy is shared and all instances can access.

</details>
<br/>
<details>
  <summary><strong>Can we call instance methods in class methods?</strong></summary>

  > No. Again, instance methods depend on being called on a specific instance. The class wouldn't know which instance to choose.

</details>
<br/>
<details>
  <summary><strong>Can we call class methods inside an instance method?</strong></summary>

  > Yes, the method is shared and can be used by all instances.

</details>

### Common Practice: No Class Variables

Developers tend not to use class variables. Instead, a more common practice is to create a higher-level class that handles the same functionality. For example, in the case of `Person`, we could have a `Group` class. Each instance of `Group` would have an instance variable `@people` which would contain each instance of `Person`.

```rb
class Group
  attr_accessor :people

  def initialize(initial_people=[])
    @people = initial_people
  end

  def add_person(person)
    @people.push(person)
  end
end

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
```

```rb
# Create instances of Group and Person
instructors = Group.new
adrian = Person.new("Adrian", 29)

# Keep track of how many instructors there are by adding `adrian` (Person) to `instructors` (Group)
instructors.add_person(adrian)

# To check how many instructors there are we can run this...
instructors.people
# => [adrian]
```

We could also add other attributes and methods to the `Group` class. It doesn't have to just be a container for instances of the `Person` class.

To illustrate the use of class variables and methods, we're going to move forward without `Group` in this lesson.

### Self

<details>
  <summary><strong>Q: What does `self` mean in Ruby?</strong></summary>

  > It contains the current instance of an object.

</details>

<details>
  <summary><strong>Q: What is the equivalent of `self` in Javascript?</strong></summary>

  > `this`

</details>

One benefit of Ruby is that it is much easier to determine what context we are working in. Unlike Javascript, we cannot redefine what context we are working with using methods like `.bind` `.call` or `.apply`.

### Add `self` to Person

<!-- AM: What's the best way to refactor `Person` using `self`? -->

To sum up:
1. Always use getter/setter methods inside the class instead of instance variables.
  * exception: you can use instance variables inside getter / setter methods themselves
2. To call a *getter* method inside a class, self is optional, e.g. both `self.name` AND `name` works
3. To call a *setter* method inside a class, you MUST use self, e.g. `self.color = red`

### You Do: Keep Building `Person`

<!-- AM: Need to update this with better prompt -->

Make the following additions to our `Person` class...

* Add support for `adrian.person_count`
* Add support for asking if a person is old enough to vote.

### Code Walkthrough (10 minutes)

<!-- AM: Is this section worth keeping? Seems the point is just to show that sometimes we create a `Config` class that ONLY contains class variables and methods. -->

**[Application Config Class in Ruby](https://github.com/ga-dc/ruby_application_configuration)**

## Break

## Inheritance

Just like we get traits from our parents, we can use a feature called **inheritance** to create multiple classes (children) that share properties and methods from their parents.

You won't need to write parent / child classes much in this class, but we will use inheritance to give some of our classes additional functionality, especially with rails in a few weeks.

We've added a `say_age` method to `Person` below to better illustrate how inheritance works in Ruby.

```rb
class Person
  attr_accessor :name
  attr_reader :age
  @@people = []

  def initialize(initial_name, initial_age)
    @name = initial_name
    @age = initial_age
    @@people.push(self)
  end

  def say_name
    puts "Hi, my name is " + @name + "."
  end

  def say_age
    puts "I am #{@age} years old."
  end

  def Person.get_people
    return @@people
  end
end

# Inheritance is indicated using the `<` symbol after the child class' name.
class LoudPerson < Person
  # LoudPerson's `say_name` overrides that of the `Person` class.
  def say_name
    puts "HEY YOU, MY NAME IS #{@name.upcase}!"
  end
end

jill = Person.new("Jill", 10)
bob = LoudPerson.new("Bob", 20)

# Both `say_age` methods produce the same result since it was not overwritten in the `LoudPerson` class.
jill.say_age
# => "I am 10 years old."
bob.say_age
# => "I am 20 years old."

# The `say_name` methods produce different results because we overwrote the original in the `LoudPerson` class.
jill.say_name
# => "My name is Jill."
bob.say_name
# => "HEY YOU, MY NAME IS BOB!"
```

### You Do: Inheritance

* Create a `QuietPerson` class that has their own version of `say_name`.
* Create a `VeryLoudPerson` class that...
  1. Shares the same attributes as `Person` and `LoudPerson`.
  2. Uses the same `say_name` method as `LoudPerson`.
  3. Has their own loud version of the `say_age` method.
* Create a `TwoHeadedPerson` class that shares the same methods as `Person` but also has a second name attribute (for the other head).

### You Do: Superheroes

<!-- AM: I'm going to add to this exercise. -->

Clone down [this repo](https://github.com/ga-wdi-exercises/superheros) and follow the instructions in the Readme.


## Visibility

<!-- AM: The placement of this seems kind of weird. Is this covered enough in the previous lesson? Or should I integrate it into the earlier review section? -->

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

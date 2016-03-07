# people6.rb: person_count
require "pry"

class Person
  attr_accessor :name
  @@person_count = 0 # class variable

  def initialize(initial_name)
    @@person_count += 1
    @name = initial_name
  end

  # instance method, just like we've seen before
  def introduction
    "Hello, I'm #{name}, one of #{Person.person_count} people"
  end

  # class method, notice the `self` in the definition, which refers to the
  # Person class
  def self.person_count
    return @@person_count
  end
end

puts Person.person_count   #=> 0
jill = Person.new("Jill")
puts Person.person_count   #=> 1
bob = Person.new("Bob")
puts Person.person_count   #=> 2


# binding.pry
puts "done." # fixes an issue with binding.pry if it's the last line of a program

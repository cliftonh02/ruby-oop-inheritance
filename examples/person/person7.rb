# person7.rb: inheritance
require "pry"

class Person
  attr_accessor :name
  attr_reader :hunger_level

  def initialize(initial_name, initial_hunger_level)
    @name = initial_name
    @hunger_level = initial_hunger_level
  end

  def introduction
    "Hello, I'm #{name}"
  end

  # Custom setter for hunger_level
  def hunger_level=(new_hunger_level)
    if new_hunger_level < 0
      @hunger_level = 0
    else
      @hunger_level = new_hunger_level
    end
    @hunger_level
  end
end

class LoudPerson < Person
  def introduction
    "HELLO, I'M #{name.upcase}"
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


# binding.pry
puts "done." # fixes an issue with binding.pry if it's the last line of a program

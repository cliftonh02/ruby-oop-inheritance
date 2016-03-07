# person7a.rb: inheritance "solution"
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
    if new_hunger_level < minimum_hunger_level
      @hunger_level = minimum_hunger_level
    else
      @hunger_level = new_hunger_level
    end
    @hunger_level
  end

  def minimum_hunger_level
    0
  end

end

class LoudPerson < Person
  def introduction
    "HELLO, I'M #{name.upcase}"
  end
end

class SleepyPerson < Person
  def introduction
    "Zzzzzzzzzz"
  end
end


class Baby < Person
  def introduction
    "Dada?  Dada!"
  end

  def minimum_hunger_level
    1
  end
end

jill = Person.new("Jill", 10)
bob = LoudPerson.new("Bob", 10)
rip = SleepyPerson.new("Rip VanWinkle", 120)
baby = Baby.new("Baby New Year", 0.1)


puts jill.introduction
puts bob.introduction
puts rip.introduction
puts baby.introduction

puts
puts "Bob's name: '#{bob.name}'"
bob.hunger_level = 5
puts "Bob hunger level: #{bob.hunger_level}"
puts "Setting bob.hunger_level = -5"
bob.hunger_level = -5
puts "Bob hunger level: #{bob.hunger_level}"

puts
puts "Setting baby.hunger_level = -5"
baby.hunger_level = -5
puts "Baby hunger level: #{baby.hunger_level}"


# binding.pry
puts "done." # fixes an issue with binding.pry if it's the last line of a program

# people5.rb: accessors
require 'pry'

# functionally identical to the previous example, much less code
class Person
  attr_accessor :name
  attr_reader :hunger_level

  def intitialize(initial_name, initial_hunger_level)
    @name = initial_name
    @hunger_level = initial_hunger_level
  end

  def introduction
    "Hello, I'm #{@name} "
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

me = Person.new

binding.pry
puts "program complete" # fixes an issue with binding.pry if it's the last line of a program

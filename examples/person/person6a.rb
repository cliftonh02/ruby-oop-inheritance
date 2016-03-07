# person6a.rb: inheritance "solution"
require "pry"

class Person
  attr_accessor :name, :age
  @@person_count = 0 # class variable

  # class method, notice the `self` in the definition, which refers to the
  # Person class
  def self.person_count
    return @@person_count
  end

  def initialize(initial_name, initial_age)
    @@person_count += 1
    @name = initial_name
    @age = initial_age
  end

  # instance method, just like we've seen before
  def introduction
    "Hello, I'm #{name}, one of #{Person.person_count} people"
  end

  def of_voting_age?
    age > voting_age_boundary
  end

  def person_count
    Person.person_count
    # OR.. self.class.person_count
  end

  def voting_age_boundary
    21
  end

  def voting_status
    "I #{of_voting_age? ? "can" : "cannot"} vote."
  end
end


puts "We have #{Person.person_count} people"
puts

jill = Person.new("Jill", 33)
puts jill.introduction
puts jill.voting_status
puts "We have #{jill.person_count} people"

puts
bob = Person.new("Bob", 16)
puts bob.introduction
puts bob.voting_status
puts "We have #{bob.person_count} people"


# binding.pry
puts "program complete" # fixes an issue with binding.pry if it's the last line of a program

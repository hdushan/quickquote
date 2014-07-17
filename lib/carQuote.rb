class CarQuote
  
  attr_reader :age, :email, :gender, :state, :make, :year
  
  @@states = {"nsw" => "New South Wales", "vic" => "Victoria", "tas" => "Tasmania", "wa" => "Western Australia", "sa" => "South Australia", "qld" => "Queensland"}
  @@genders = {"male" => "Male", "female" => "Female"}
  @@makes = {"audi" => "Audi", "alfa" => "Alfa Romeo", "bmw" => "BMW", "lexus" => "Lexus", "toyota" => "Toyota", "vw" => "Volkswagen"}
    
  def initialize(age, email, state, make, gender, year)
    @age = age.to_i
    @email = email
    @state = state
    @make = make
    @gender = gender
    @year = year
  end
  
  def namedState
    @@states[@state]
  end
  
  def namedMake
    @@makes[@make]
  end
  
  def namedGender
    @@genders[@gender]
  end
  
end
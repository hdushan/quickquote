class LifeQuote
  
  attr_reader :age, :email, :gender, :state, :occupationCategory
  
  @@states = {"nsw" => "New South Wales", "vic" => "Victoria", "tas" => "Tasmania", "wa" => "Western Australia", "sa" => "South Australia", "qld" => "Queensland"}
  @@genders = {"male" => "Male", "female" => "Female"}
  @@occupationCategories = {"risk0" => "Low risk occupation", "risk1" => "Medium risk occupation", "risk2" => "High risk occupation", "risk3" => "Very High risk occupation"}
    
  def initialize(age, email, state, occupationCategory, gender)
    @age = age.to_i
    @email = email
    @state = state
    @occupationCategory = occupationCategory
    @gender = gender
  end
  
  def namedState
    @@states[@state]
  end
  
  def namedOccupationCategory
    @@occupationCategories[@occupationCategory]
  end
  
  def namedGender
    @@genders[@gender]
  end
  
end
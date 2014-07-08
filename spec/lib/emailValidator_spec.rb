require 'spec_helper'
require 'emailValidator'

describe EmailValidator do

  emailValidator = EmailValidator.new()
        
  describe '#isEmailValid?' do
    it 'should return false if there is no "@"' do
      expect(emailValidator.isEmailValid?("hans")).to be false
    end
    
    it 'should return false if there is no "."' do
      expect(emailValidator.isEmailValid?("hans@gmail")).to be false
    end
    
    it 'should return false if there is no domain name' do
      expect(emailValidator.isEmailValid?("hans@gmail.")).to be false
    end
    
    it 'should return false if there is no username' do
      expect(emailValidator.isEmailValid?("@gmail.com")).to be false
    end
    
    it 'should return false if email is blank' do
      expect(emailValidator.isEmailValid?("")).to be false
    end
    
    it 'should return true if email is proper' do
      expect(emailValidator.isEmailValid?("hans@gmail.com")).to be true
    end
  end
end

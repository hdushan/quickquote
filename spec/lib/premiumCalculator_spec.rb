require 'spec_helper'
require 'premiumCalculator'
require 'quote'

describe PremiumCalculator do

  premiumCalculator = PremiumCalculator.new()
        
  describe '#getPremiumForQuote' do
    it 'should return right premium for a 23 year old, high risk male in NSW' do
      quote = Quote.new(23, "email@gmail.com", "nsw", "risk2", "male")
      expect(premiumCalculator.getPremiumForQuote(quote)).to eq 55.54
    end
  end
end

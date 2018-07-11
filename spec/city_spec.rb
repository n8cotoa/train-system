require 'rspec'
require 'pry'
require 'city'
require 'spec_helper'
require 'pg'

describe(City) do
  describe('#all') do
    it "will display all values of city class" do
      expect(City.all).to(eq([]))
    end
  end

end

require 'rspec'
require 'pry'
require 'train'
require 'spec_helper'
require 'pg'

describe(Train) do
  describe(".all") do
    it("will list all instances of Train class") do
      expect(Train.all).to(eq([]))
    end
  end
  describe("#save") do
    it("save instance of train")
  end
end

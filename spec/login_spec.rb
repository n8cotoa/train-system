require 'spec_helper'
require 'rspec'
require 'pry'
require 'login'
require 'pg'

describe(Login) do
  describe('#login?') do
    it('will take a user email and password and compare to database') do
      login_test = Login.new({:email => 'test@gmail.com', :password => 'test_pass'})
      expect(login_test.login?).to(eq(false))
    end
  end
end

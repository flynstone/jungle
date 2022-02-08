require "rails_helper"

RSpec.describe User, type: :model do

  describe "User Validations" do
    it "should have matching password and password_confirmation" do
      @user = User.new(first_name: "Julien", last_name: "Lacroix", email: "fake@email.com", password: "p@ssword", password_confirmation: "p@ssword")
      @user.save
      expect(@user.password).to eq(@user.password_confirmation)  
    end

    it "should not be able to register with an empty password" do
      @password = User.new(first_name: "Julien", last_name: "Lacroix", email: "fake@email.com", password: nil, password_confirmation: nil)
      @password.save
      expect(User.where(password: "p@ssword"))
    end

    it "cannot register if email is already registered" do
      @first = User.new(name: "Julien", last_name: "Lacroix", email: "fake@email.com", password: "p@ssword", password_confirmation: "p@ssword" )
      @second = User.new(name: "Julien", last_name: "Lacroix", email: "FAKE@email.com", password: "p@ssword", password_confirmation: "p@ssword" )
      @first.save
      @second.save
      expect(User.where(email: "fake@email.com").count) == 1
    end

    it "should not be able to register with an empty email" do
      @user = User.new(first_name: "Julien", last_name: "Lacroix", email: nil, password: "p@ssword", password_confirmation: "p@ssword")
      @user.save
      expect(User.where(email: "fake@email.com"))
    end

    it "should not be able to register with an empty first name" do
      @user = User.new(first_name: nil, last_name: "Lacroix", email: "fake@email.com", password: "p@ssword", password_confirmation: "p@ssword")
      @user.save
      expect(User.where(email: "fake@email.com"))
    end

    it "should not be able to register with an empty last name" do
      @user = User.new(first_name: "Julien", last_name: nil, email: "fake@email.com", password: "p@ssword", password_confirmation: "p@ssword")
      @user.save
      expect(User.where(email: "fake@email.com"))
    end

    it "should not be able to register with a password less than 3 characters" do
      @user = User.new(name: "Julien", last_name: "Lacroix", email: "fake@email.com", password: "123", password_confirmation: "123" )
      @user.save
      
      expect(User.where(email: "fake@email.com").count) == 0
    end
  end

  describe ".authenticate_with_credentials" do

    it "should allow users to login if email and password match" do
      @user = User.new(name: "Julien", last_name: "Lacroix", email: "fake@email.com", password: "1234")
      @user.save

      expect(User.authenticate_with_credentials("fake@email.com", "1234")).to eq(@user)

      expect(User.authenticate_with_credentials("fake@email.com", "qwer")).to eq(nil)

      expect(User.authenticate_with_credentials("wrong@email.com", "1234")).to eq(nil)
    end

    it "should authenticate emails if extra spaces are added before or after" do
      @user = User.new(name: "Julien", last_name: "Lacroix", email: "fake@email.com", password: "1234")
      @user.save

      expect(User.authenticate_with_credentials("fake@email.com", "1234")).to eq(@user)
    end

    it "should authenticate email if email is different case" do
      @user = User.new(name: "Julien", last_name: "Lacroix", email: "FaKe@email.com", password: "1234")
      @user.save

      expect(User.authenticate_with_credentials("fake@email.com", "1234")).to eq(@user)
    end
  end
end
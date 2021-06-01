require 'rails_helper'

RSpec.describe User, type: :model do

  describe "Validations" do

    name = "Joe"
    email = "joe@joe.ca"
    password = "password"
    password_confirmation = "password"

    it 'should create a new valid user' do
      user = User.create({name: name, email: email, password: password, password_confirmation: password_confirmation})
      expect(user.valid?).to be true
    end

    it 'should give an error message when name is nil' do
      user = User.new({name: nil, email: email, password: password, password_confirmation: password_confirmation})
      expect(user.valid?).to be false
      expect(user.errors.full_messages.first).to eq "Name can't be blank"
    end

    it 'should give an error message when email is nil' do
      user = User.new({name: name, email: nil, password: password, password_confirmation: password_confirmation})
      expect(user.valid?).to be false
      expect(user.errors.full_messages.first).to eq "Email can't be blank"
    end

    it 'should give an error message when password is nil' do
      user = User.new({name: name, email: email, password: nil, password_confirmation: password_confirmation})
      expect(user.valid?).to be false
      expect(user.errors.full_messages.first).to eq "Password can't be blank"
    end

    it 'should give an error message when password_confirmation is nil' do
      user = User.new({name: name, email: email, password: password, password_confirmation: nil})
      expect(user.valid?).to be false
      expect(user.errors.full_messages.first).to eq "Password confirmation can't be blank"
    end

    it 'should give an error message when password does not equal password_confirmation' do
      user = User.new({name: name, email: email, password: password, password_confirmation: "wrong_password"})
      expect(user.valid?).to be false
      expect(user.errors.full_messages.first).to eq "Password confirmation doesn't match Password"
    end

    it 'should give an error message if the email already exists - case insensitive' do
      user1 = User.create({name: name, email: email, password: password, password_confirmation: password_confirmation})
      user2 = User.create({name: name, email: "JOE@joe.CA", password: password, password_confirmation: password_confirmation})
      expect(user1.valid?).to be true
      expect(user2.valid?).to be false
      expect(user2.errors.full_messages.first).to eq "Email has already been taken"
    end

    it 'should give an error message if the password is too short' do
      user = User.create({name: name, email: email, password: "pass", password_confirmation: "pass"})
      expect(user.valid?).to be false
      expect(user.errors.full_messages.first).to eq "Password is too short (minimum is 8 characters)"
    end
  end

  describe '.authenticate_with_credentials' do

    name = "Joe"
    email = "joe@joe.ca"
    password = "password"
    password_confirmation = "password"

    it 'should authenticate a user with the correct credentials' do
      user = User.create({name: name, email: email, password: password, password_confirmation: password_confirmation})
      expect(User.authenticate_with_credentials("joe@joe.ca", "password")).to eq user
    end
    it 'should authenticate a user using email with spaces' do
      user = User.create({name: name, email: email, password: password, password_confirmation: password_confirmation})
      expect(User.authenticate_with_credentials("  joe@joe.ca  ", "password")).to eq user
    end
    it 'should authenticate a user using email with random uppercase letters' do
      user = User.create({name: name, email: "jOe@Joe.Ca", password: password, password_confirmation: password_confirmation})
      expect(User.authenticate_with_credentials("JoE@joE.cA", "password")).to eq user
    end
  end
end

require 'rails_helper'

RSpec.describe User, type: :model do
  it 'validates user when fields and password - password_confirmation are correct' do
    @user = User.new(first_name: 'Miguel', last_name: 'Cruz', email: 'm@m.m', password:'verysafepwd', password_confirmation:'verysafepwd');
    expect(@user).to be_valid
  end
  it 'invalid user when fields and password - password_confirmation are not correct' do
    @user = User.new(first_name: 'Miguel', last_name: 'Cruz', email: 'm@m.m', password:'verysafepwd', password_confirmation:'someotherpwd');
    expect(@user).to_not be_valid
  end
  it 'invalid user when password_confirmation is not provided' do
    @user = User.new(first_name: 'Miguel', last_name: 'Cruz', email: 'm@m.m', password:'verysafepwd');
    expect(@user).to_not be_valid
  end
  it 'validates first_name presence' do
    @user = User.new(first_name: nil, last_name: 'Cruz', email: 'm@m.m', password:'verysafepwd', password_confirmation:'verysafepwd');
    expect(@user).to_not be_valid
  end
  it 'validates last_name presence' do
    @user = User.new(first_name: 'Miguel', last_name: nil, email: 'm@m.m', password:'verysafepwd', password_confirmation:'verysafepwd');
    expect(@user).to_not be_valid
  end
  it 'validates email presence' do
    @user = User.new(first_name: 'Miguel', last_name: 'Cruz', email: nil, password:'verysafepwd', password_confirmation:'verysafepwd');
    expect(@user).to_not be_valid
  end
  it 'validates email must be unique' do
    @user1 = User.new(first_name: 'Miguel', last_name: 'Cruz', email: 'm@m.m', password:'verysafepwd', password_confirmation:'verysafepwd');
    @user1.save!
    @user2 = User.new(first_name: 'Miguel', last_name: 'Cruz', email: 'm@M.m', password:'verysafepwd', password_confirmation:'verysafepwd');
    expect(@user2).to_not be_valid
  end
  it 'validates password must be 3 min length' do
    @user = User.new(first_name: 'Miguel', last_name: 'Cruz', email: 'm@m.m', password:'ve', password_confirmation:'ve');
    expect(@user).to_not be_valid
  end
end

describe '.authenticate_with_credentials' do
  # examples for this class method here
  it 'validates successful login with correct credentials' do
    @user = User.new(first_name: 'Miguel', last_name: 'Cruz', email: 'm@m.m', password:'ver', password_confirmation:'ver');
    @user.save!
    isValid = User.authenticate_with_credentials(@user.email, @user.password)
    expect(isValid).to be_truthy
  end
  it 'validates successful login with incorrect credentials' do
    @user = User.new(first_name: 'Miguel', last_name: 'Cruz', email: 'm@m.m', password:'ver', password_confirmation:'ver');
    @user.save!
    isValid = User.authenticate_with_credentials(@user.email, '@user.password')
    expect(isValid).to_not be_truthy
  end
  it 'validates that spaces before and/or after their email/password are removed' do
    @user = User.new(first_name: 'Miguel', last_name: 'Cruz', email: 'm@m.m', password:'ver', password_confirmation:'ver');
    @user.save!
    isValid = User.authenticate_with_credentials(" #{@user.email} ", " #{@user.password} ")
    expect(isValid).to be_truthy
  end
  it 'validates that email is case insensitive' do
    @user = User.new(first_name: 'Miguel', last_name: 'Cruz', email: 'm@m.m', password:'ver', password_confirmation:'ver');
    @user.save!
    isValid = User.authenticate_with_credentials("M@m.M", @user.password)
    expect(isValid).to be_truthy
  end
end

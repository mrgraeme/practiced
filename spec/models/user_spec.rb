require 'spec_helper'

describe User do

  before(:each) do
    @attr = { :name => "Example User", 
      :email => "user@example.com",
      :password => "password",
      :password_confirmation => "password" 
    }
  end

  it "should create a new instance given valid attributes" do
    User.create(@attr)
  end

  it "should require a name" do
    no_name_user = User.new(@attr.merge(:name => ""))
    no_name_user.should_not be_valid
  end

  it "should require an email" do
    no_email_user = User.new(@attr.merge(:email => ""))
    no_email_user.should_not be_valid
  end

  it "should reject long names" do
    long_name = "x" * 51
    long_name_user = User.new(@attr.merge(:name => long_name))
    long_name_user.should_not be_valid
  end

  it "should accept valid email formats" do
    addresses = %w[user@example.com user_two@example.email.com user.three@eg.co.uk]
    addresses.each do |a|
      valid_email_user = User.new(@attr.merge(:email => a))
      valid_email_user.should be_valid
    end
  end

  it "should reject invalid email formats" do
    addresses = %w[user@example,com user_two_at_example.email.com user.three@eg.]
    addresses.each do |a|
      invalid_email_user = User.new(@attr.merge(:email => a))
      invalid_email_user.should_not be_valid
    end
  end

  it "should reject duplicate email addresses" do
    User.create!(@attr)
    user_with_duplicate_email = User.new(@attr)
    user_with_duplicate_email.should_not be_valid
  end

  it "should reject email addresses identical up to case" do
    upcased_email = @attr[:email].upcase
    User.create!(@attr.merge(:email => upcased_email))
    user_with_duplicate_email = User.new(@attr)
    user_with_duplicate_email.should_not be_valid
  end

  describe "password validations" do

    it "should require a password" do
      User.new(@attr.merge(:password => "", :password_confirmation => "")).should_not be_valid
    end

    it "should require a matching password confirmation" do
      User.new(@attr.merge(:password_confirmation => "incorrect")).should_not be_valid
    end

    it "should reject short passwords below 5 character" do
      short_password = "x" * 4
      User.new(@attr.merge(:password => short_password, :password_confirmation => short_password)).should_not be_valid
    end

    it "should reject long passwords over 20 characters" do
      long_password = "x" * 21
      User.new(@attr.merge(:password => long_password, :password_confirmation => long_password)).should_not be_valid
    end  

  end

  describe "password encryption" do

    before(:each) do
      @user = User.create!(@attr)
    end

    it "should have an encrypted password attribute" do
      @user.should respond_to(:encrypted_password)
    end

    it "should set encrypted password" do
      @user.encrypted_password.should_not be_blank
    end

    describe "has_password? method" do

      it "should be true if passwords match" do
        @user.has_password?(@attr[:password]).should be_true
      end

      it "should be false if passwords do not match" do
        @user.has_password?("invalid").should be_false
      end

    end

    describe "authenticate method" do

      it "should return nil on email/password mismatch" do
        wrong_password_user = User.authenticate(@attr[:email], "wrongpass")
        wrong_password_user.should be_nil
      end

      it "shoulf return nil for an email address with no user" do
        nonexistent_user = User.authenticate("noone@nope.com", @attr[:password])
      end

      it "should return the user on email/password match" do
        matching_user = User.authenticate(@attr[:email], @attr[:password])
        matching_user.should == @user
      end
    end
  end
end


# == Schema Information
#
# Table name: users
#
#  id                 :integer         not null, primary key
#  name               :string(255)
#  email              :string(255)
#  created_at         :datetime
#  updated_at         :datetime
#  encrypted_password :string(255)
#  salt               :string(255)
#


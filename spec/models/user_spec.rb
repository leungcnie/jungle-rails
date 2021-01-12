require 'rails_helper'

RSpec.describe User, type: :model do

  describe 'Validations' do
    # validation examples here
    it 'should save user if all fields valid and filled' do
      user = User.new
      user.password = 'testpass'
      user.password_confirmation = 'testpass'
      user.email = 'scream@test.com'
      user.first_name = 'Lob'
      user.last_name = 'Jam'
      user.save
      expect(user).to be_valid
    end

    it 'should not save a user is password is blank' do
      user = User.new
      user.password = nil
      user.password_confirmation = 'testpass'
      user.email = 'behest@test.com'
      user.first_name = 'Bob'
      user.last_name = 'Lam'
      user.save
      expect(user.errors.full_messages).to include("Password can't be blank")
    end

    it 'should raise an error if password is 4 characters long' do
      user = User.new
      user.password = '1234'
      user.password_confirmation = '1234'
      user.email = 'best@test.com'
      user.first_name = 'Mob'
      user.last_name = 'Sam'
      user.save
      expect(user.errors.full_messages).to include("Password is too short (minimum is 5 characters)")
    end

    it 'should not raise an error if password is 5 characters long' do
      user = User.new
      user.password = '12345'
      user.password_confirmation = '12345'
      user.email = 'rest@test.com'
      user.first_name = 'Gob'
      user.last_name = 'Tam'
      user.save
      expect(user).to be_valid
    end
    
    it 'should not save a user if password_confirmation is blank' do
      user = User.new
      user.password = 'password'
      user.password_confirmation = nil
      user.email = 'zest@test.com'
      user.first_name = 'Yob'
      user.last_name = 'Fam'
      user.save
      expect(user.errors.full_messages).to include("Password confirmation can't be blank")
    end

    it 'should not save user if password and password confirmation are not the same' do
      user = User.new
      user.password = 'password'
      user.password_confirmation = 'testpass'
      user.email = 'qest@test.com'
      user.first_name = 'Pob'
      user.last_name = 'Vam'
      user.save
      expect(user.errors.full_messages).to include("Password confirmation doesn't match Password")
    end

    it 'should not save a user if email is blank' do
      user = User.new
      user.password = 'testpass'
      user.password_confirmation = 'testpass'
      user.email = nil
      user.first_name = 'Hob'
      user.last_name = 'Ram'
      user.save
      expect(user.errors.full_messages).to include("Email can't be blank")
    end

    it 'should not create a user with email TEST@TEST.com if test@test.COM is in db' do
      user = User.new
      user.password = 'testpass'
      user.password_confirmation = 'testpass'
      user.email = 'test@test.com'
      user.first_name = 'Nob'
      user.last_name = 'Ram'
      user.save

      user2 = User.create(
        password: '12345',
        password_confirmation: '12345',
        email: 'TEST@TEST.com',
        first_name: 'Yee',
        last_name: 'Haw', 
      )

      expect(user2).to_not be_valid
    end
    
    it 'should not save a user if first_name is blank' do
      user = User.new
      user.password = 'testpass'
      user.password_confirmation = 'testpass'
      user.email = 'ajsdh@test.com'
      user.first_name = nil
      user.last_name = 'Cam'
      user.save
      expect(user.errors.full_messages).to include("First name can't be blank")
    end
    
    it 'should not save a user if last_name is blank' do
      user = User.new
      user.password = 'testpass'
      user.password_confirmation = 'testpass'
      user.email = 'adsfsgdh@test.com'
      user.first_name = 'Pob'
      user.last_name = nil
      user.save
      expect(user.errors.full_messages).to include("Last name can't be blank")
    end

  end

  describe '.authenticate_with_credentials' do
    # examples for this class method here
    it "should authenticate user with ' example@domain.com ' if their email is 'example@domain.com'" do
      user = User.new
      user.password = 'testpass'
      user.password_confirmation = 'testpass'
      user.email = 'example@domain.com'
      user.first_name = 'Job'
      user.last_name = 'Tam'
      user.save
      logged_in_user = User.authenticate_with_credentials(' example@domain.com ', 'testpass')
      expect(logged_in_user).to eq(user)
    end

    it "should authenticate user with 'eXample@domain.COM' if their email is 'EXAMPLe@DOMAIN.CoM'" do
      user = User.new
      user.password = 'testpass'
      user.password_confirmation = 'testpass'
      user.email = 'EXAMPLe@DOMAIN.CoM'
      user.first_name = 'Nob'
      user.last_name = 'Bam'
      user.save
      logged_in_user = User.authenticate_with_credentials('eXample@domain.COM', 'testpass')
      expect(logged_in_user).to eq(user)
    end
 
    it "should not authenticate user if password is wrong" do
      user = User.new
      user.password = 'testpass'
      user.password_confirmation = 'testpass'
      user.email = 'nyeh@DOMAIN.CoM'
      user.first_name = 'Dob'
      user.last_name = 'Yam'
      user.save
      logged_in_user = User.authenticate_with_credentials('nyeh@DOMAIN.CoM', 'diffyhinuig')
      expect(logged_in_user).to eq(nil)
    end

    it "should not authenticate user if email isn't in db" do
      user = User.new
      user.password = 'testpass'
      user.password_confirmation = 'testpass'
      user.email = 'ah@DOMAIN.CoM'
      user.first_name = 'Hob'
      user.last_name = 'Gam'
      user.save
      logged_in_user = User.authenticate_with_credentials('hueheuh@DOMAIN.CoM', 'testpass')
      expect(logged_in_user).to eq(nil)
    end

  end
end

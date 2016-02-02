require 'spec_helper'
require 'rails_helper'

def sign_up(username)
  visit "/users/new"
  fill_in "Username", with: username
  fill_in "Password", with: 'abcdef'
  click_button 'Sign Up'
end

def sign_up_as_ginger_baker
  sign_up("ginger_baker")
end

feature "the signup process" do

  it "has a new user page" do
    visit "/users/new"
    expect(page).to have_content "Sign Up"
  end

  feature "signing up a user" do


    it "has appropriate fields" do
      visit "/users/new"
      expect(page).to have_content "Username"
      expect(page).to have_content "Password"
      expect(page).to have_button "Sign Up"

    end

    it "rejects a blank (zero-length) password" do
      visit "/users/new"
      fill_in "Username", with: 'ginger_baker'
      click_button 'Sign Up'

      expect(page).to have_content 'Sign Up'
      expect(page).to have_content 'Password is too short'
    end

    it "validates that the password is at least 6 characters long" do
      visit "users/new"
      fill_in "Username", with: 'ginger_baker'
      fill_in "Password", with: 'short'
      click_button 'Sign Up'
      expect(page).to have_content 'Sign Up'
      expect(page).to have_content 'Password is too short'
    end

    it "shows username on the homepage after signup" do
      visit "users/new"

      fill_in "Username", with: 'ginger_baker'
      fill_in "Password", with: 'password'
      click_button 'Sign Up'
      expect(page).to have_content 'ginger_baker'
    end


  end

end

feature "logging in" do

  it "shows username on the homepage after login" do

  end
  it "validates that the log in information is correct" do
    sign_up_as_ginger_baker
    visit "/session/new"
    fill_in "Username", with: 'ginger_baker'
    fill_in "Password", with: 'PaSSw0Rd'
    click_button 'Sign In'
    expect(page).to have_content 'Sign In'
    expect(page).to have_content "Invalid Username/Password combination"
  end

  it "redirects to user's page after successful log in" do
    sign_up_as_ginger_baker
    visit "/session/new"
    fill_in "Username", with: 'ginger_baker'
    fill_in "Password", with: 'password'
    click_button 'Sign In'
    expect(page).to have_content 'ginger_baker'
  end



end

feature "logging out" do

  it "begins with logged out state" do
    visit "/session/new"
    expect(page).to have_no_content "Sign Out"
  end

  it "doesn't show username on the homepage after logout" do
    sign_up_as_ginger_baker
    click_button 'Sign Out'
    expect(page).to have_content "Sign In"
    expect(page).to have_no_content "ginger_baker"
  end

end

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


feature "creating a goal" do

  it "user page has a new goal link" do
    sign_up_as_ginger_baker
    expect(page).to have_link "Create Goal"
  end

  it "clicking Create Goal link takes the user to a... y'know, goal creation page." do
    sign_up_as_ginger_baker
    click_link "Create Goal"
    expect(page).to have_content("New Goal")
  end

  it "/goals/new has FIELDS" do
    sign_up_as_ginger_baker
    click_link "Create Goal"
    expect(page).to have_field "Name"
    expect(page).to have_field "Visible"
    expect(page).to have_button "Create Goal"
  end

  it "displays the created goal on the user page" do
    sign_up_as_ginger_baker
    click_link "Create Goal"
    fill_in "Name", with: 'Hundred Push-Ups'
    choose "Visible_False"
    click_button "Create Goal"
    expect(page).to have_content "Hundred Push-Ups"
  end

end

feature "user page displays goals" do

  it "shows a list of goals" do
    sign_up_as_ginger_baker
    expect(page).to have_content "Goals:"

  end

end

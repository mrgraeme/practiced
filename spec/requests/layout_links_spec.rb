require 'spec_helper'

describe "LayoutLinks" do

  it "should have a home page at '/'" do
    get '/'
    response.should have_selector('title', :content => 'Home')
  end

  it "should have a contact page at '/contact'" do
    get '/contact'
    response.should have_selector('title', :content => 'Contact')
  end

  it "should have a about page at '/about'" do
    get '/about'
    response.should have_selector('title', :content => 'About')
  end

  it "should have a help page at '/help'" do
    get '/help'
    response.should have_selector('title', :content => 'Help')
  end

  it "should have a signup page at '/signup'" do
    get "/signup"
    response.should have_selector('title', :content => 'Sign up')
  end
  
  
  

  it "should have About page when clicking on the about link" do
    visit root_path
    click_link "About"
    response.should have_selector('title', :content => 'About')
  end
  
  it "should have Contact page when clicking on the about link" do
    visit root_path
    click_link "Contact"
    response.should have_selector('title', :content => 'Contact')
  end
  
  it "should have Help page when clicking on the about link" do
    visit root_path
    click_link "Help"
    response.should have_selector('title', :content => 'Help')
  end
  
  it "should have Home page when clicking on the about link" do
    visit root_path
    click_link "Home"
    response.should have_selector('title', :content => 'Home')
  end
  
  it "should have Signup page when clicking on the about link" do
    visit root_path
    click_link "sign up now!"
    response.should have_selector('title', :content => 'Sign up')
  end
  

  end


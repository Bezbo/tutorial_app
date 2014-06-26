require 'spec_helper'

describe "StaticPages" do

  describe "home page" do

    it "should have content 'Tutorial App' " do
      visit '/static_pages/home'
      expect(page).to have_content("Tutorial App")
    end

    it "should have right title" do
      visit '/static_pages/home'
      expect(page).to have_title("Home")
    end
  end

  describe "help page" do

    it "should have content 'help'" do
      visit '/static_pages/help'
      expect(page).to have_content("Help")
    end

    it "should have right title" do
      visit '/static_pages/help'
      expect(page).to have_title("Help")
    end
  end

  describe "about us page" do

    it "should have content 'About Us'" do
      visit '/static_pages/about'
      expect(page).to have_content("About Us")
    end

    it "should have right title" do
      visit '/static_pages/about'
      expect(page).to have_title("About Us")
    end
  end

  describe "contact page" do

    it "should have content 'Contact'" do
      visit '/static_pages/contact'
      expect(page).to have_content("Contact")
    end

    it "should have right title" do
      visit '/static_pages/contact'
      expect(page).to have_title("Contact")
    end
  end

end

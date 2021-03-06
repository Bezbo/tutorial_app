require 'spec_helper'

describe "StaticPages" do

  subject { page }

  shared_examples_for "all static pages" do
    it { should have_selector("h1", text: heading) }
    it { should have_title(full_title(page_title)) }
  end

  describe "home page" do
    before{ visit root_path }

    let(:heading)    { "Tutorial App" }
    let(:page_title) { "" }

    it_should_behave_like "all static pages"
    it { should_not have_title("| Home") }

    describe "for signed in users" do
      let(:user) { FactoryGirl.create(:user) }
      before do
        FactoryGirl.create(:micropost, user: user, content: "Lorem ipsum")
        FactoryGirl.create(:micropost, user: user, content: "Dolor sit amet")
        sign_in user
        visit root_path
      end

      it "should render the user's feed" do
        user.feed.each do |item|
          expect(page).to have_selector("li##{item.id}", text: item.content)
        end
      end

      describe "follower/following counts" do
        let(:other_user) { FactoryGirl.create(:user) }
        before do
          other_user.follow!(user)
          visit root_path
        end

        it { should have_link("0 following", href: following_user_path(user)) }
        it { should have_link("1 followers", href: followers_user_path(user)) }
      end

      describe "micropost counts" do
        before { click_link "delete", match: :first }
        it "should be singular when count equal to 1" do
          expect(page).to have_selector("span", text: "1 micropost")
        end
      end
    end
  end

  describe "help page" do
    before{ visit help_path }

    let(:heading)    { "Help" }
    let(:page_title) { "Help" }

    it_should_behave_like "all static pages"
  end

  describe "about us page" do
    before{ visit about_path }

    let(:heading)    { "About Us" }
    let(:page_title) { "About Us" }

    it_should_behave_like "all static pages"
  end

  describe "contact page" do
    before{ visit contact_path }

    let(:heading)    { "Contact" }
    let(:page_title) { "Contact" }

    it_should_behave_like "all static pages"
  end

  it "should have the right links on the layout" do
    visit root_path

    click_link "About"
    expect(page).to have_title(full_title("About Us"))
    click_link "Help"
    expect(page).to have_title(full_title("Help"))
    click_link "Contact"
    expect(page).to have_title(full_title("Contact"))
    click_link "Home"
    click_link "Sign up!"
    expect(page).to have_title(full_title("Sign up"))
    click_link "tutorial app"
    expect(page).to have_selector("h1", text: "Tutorial App")
  end

  describe "micropost pagination" do
    let(:user) { FactoryGirl.create(:user) }
    before do
      31.times { FactoryGirl.create(:micropost, user: user) }
      sign_in user
      visit root_path
    end
    after { user.microposts.destroy_all }

    it { should have_selector("div.pagination") }
  end
end

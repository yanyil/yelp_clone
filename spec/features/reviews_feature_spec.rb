require 'rails_helper'

feature 'reviews' do
  context 'users can leave their reviews' do
    before do
      Restaurant.create(name: 'KFC', description: 'very fancy restaurant')
    end

    scenario 'review a restaurant' do
      visit '/restaurants'
      click_link 'Review KFC'
      fill_in 'Thoughts', with: "It's extremely fancy!"
      select '5', from: 'Rating'
      click_button 'Submit'
      expect(page).to have_content "It's extremely fancy!"
    end
  end
end
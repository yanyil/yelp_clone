require 'rails_helper'

feature 'restaurants' do
  context 'No restaurants have been added' do
    scenario 'should display a prompt to add a restaurant' do
      visit '/restaurants'
      expect(page).to have_content 'No restaurants yet'
      expect(page).to have_link 'Add a restaurant'
    end
  end

  context 'restaurants have been added' do
    before do
      Restaurant.create(name: 'KFC', description: 'very fancy restaurant')
    end

    scenario 'display restaurants' do
      visit '/restaurants'
      expect(page).to have_content('KFC')
      expect(page).to have_content('very fancy restaurant')
      expect(page).not_to have_content('No restaurants yet')
    end
  end

  context 'restaurants can be updated' do
    before do
      Restaurant.create(name: 'KFC', description: 'very fancy restaurant')
    end

    scenario 'update restaurant' do
      visit '/restaurants'
      click_link 'Edit KFC'
      fill_in "Name", with: 'Not that other place'
      fill_in "Description", with: 'terribly fancy restaurant'
      click_button 'Update'
      expect(page).not_to have_content 'KFC'
      expect(page).to have_content 'Not that other place'
    end
  end

  context 'restaurants can be deleted' do
    before do
      Restaurant.create(name: 'KFC', description: 'very fancy restaurant')
    end

    scenario 'delete restaurant' do
      visit '/restaurants'
      click_link 'Delete KFC'
      expect(page).to have_content 'Successfully deleted KFC'
    end
  end

  context 'restaurants have their own page' do

    let!(:kfc) {Restaurant.create(name: 'KFC', description: 'very fancy restaurant')}

    scenario 'show restaurant' do
      visit '/restaurants'
      click_link 'Show KFC'
      expect(page).to have_content 'KFC'
      expect(current_path).to eq "/restaurants/#{kfc.id}"
      expect(page).to have_content 'very fancy restaurant'
    end
  end
end
require 'rails_helper'

RSpec.feature "Visitor navigates to categories", type: :feature, js: true do
  
  # SETUP
  before :each do
    @category1 = Category.create! name: 'Apparel'

    5.times do |n|
      @category1.products.create!(
        name:  Faker::Hipster.sentence(3),
        description: Faker::Hipster.paragraph(4),
        image: open_asset('apparel1.jpg'),
        quantity: 10,
        price: 64.99
      )
    end
  end

  scenario "They see all products in Apparel category" do
    # ACT
    visit root_path

    find('.pull-right', match: :first).click

    # click_on 'Categories'
    # select 'Categories'
    # DEBUG
    expect(page).to have_css '.products-show'
    save_screenshot "test2.png"

    # VERIFY
  end
end
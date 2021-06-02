require 'rails_helper'

RSpec.feature "Visitor adds a product to their cart", type: :feature, js: true do
  
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

  scenario "They see the cart increase in number" do
    # ACT
    visit root_path

    find('.btn-primary', match: :first).click

    # click_on 'Categories'
    # select 'Categories'
    # DEBUG
    expect(page).to have_content 'My Cart (1)'
    
    save_screenshot "test3.png"
    # VERIFY
  end
end
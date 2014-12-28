feature 'Update ticket by user' do

  scenario 'user updates an ticket' do
    FactoryGirl.create :user, role: :customer
    FactoryGirl.create :status, flag: :initial
    ticket = FactoryGirl.create :ticket

    visit ticket_path(ticket)

    expect(page.has_no_select? "Status").to be true
    expect(page.has_no_select? "Owner").to be true

    message = Faker::Lorem.sentence
    fill_in 'Message', with: message

    click_button 'Save'

    expect(page).to have_content message
  end

end



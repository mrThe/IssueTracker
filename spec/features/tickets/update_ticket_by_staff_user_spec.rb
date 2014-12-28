feature 'Update ticket by staff user' do

  scenario 'staff user updates an ticket' do
    FactoryGirl.create :status, flag: :initial
    FactoryGirl.create :user, role: :customer
    staff = FactoryGirl.create :user, role: :staff
    ticket = FactoryGirl.create :ticket

    signin(staff.email, staff.password)

    visit ticket_path(ticket)

    expect(page.has_select? "Status").to be true
    expect(page.has_select? "Owner").to be true

    message = Faker::Lorem.sentence
    fill_in 'Message', with: message

    click_button 'Save'

    expect(page).to have_content message
  end

end



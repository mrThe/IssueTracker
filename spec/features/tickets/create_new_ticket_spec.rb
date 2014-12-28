feature 'Create new ticket' do

  scenario 'user creates new ticket' do
    FactoryGirl.create :status, flag: :initial
    ticket = FactoryGirl.build :ticket

    visit '/'

    fill_in 'Your name',  with: ticket.customer_name
    fill_in 'Your email', with: ticket.customer_email
    fill_in 'Subject',    with: ticket.subject
    fill_in 'Message',    with: ticket.message

    click_button 'Save'

    expect(page).to have_content ticket.customer_name
    expect(page).to have_content ticket.customer_email
    expect(page).to have_content ticket.subject
    expect(page).to have_content ticket.message
    expect(page).to have_content "History"
  end

end



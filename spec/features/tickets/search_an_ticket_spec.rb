feature 'Search tickets' do

  scenario 'staff user search through tickets' do
    FactoryGirl.create :status, flag: :initial
    FactoryGirl.create :user, role: :customer
    staff = FactoryGirl.create :user, role: :staff
    ticket = FactoryGirl.create :ticket

    signin(staff.email, staff.password)

    visit tickets_path

    fill_in 'Search', with: ticket.subject.split(' ').sample(2).join(' ')
    click_button 'Search'
    expect(page).to have_content ticket.sub_id

    fill_in 'Search', with: ticket.message.split(' ').sample(2).join(' ')
    click_button 'Search'
    expect(page).to have_content ticket.sub_id

    fill_in 'Search', with: ticket.sub_id
    click_button 'Search'
    expect(page).to have_content ticket.sub_id
  end

end



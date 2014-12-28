feature 'Tickets navigation' do

  scenario 'staff user navigate through tickets' do
    FactoryGirl.create :status, flag: :initial
    FactoryGirl.create :user, role: :customer
    staff = FactoryGirl.create :user, role: :staff

    unassigned_waiting_ticket = FactoryGirl.create :ticket, owner: nil, status: FactoryGirl.create(:status, :waiting)
    initial_ticket = FactoryGirl.create :ticket, owner: staff, status: FactoryGirl.create(:status, :initial)
    waiting_ticket = FactoryGirl.create :ticket, owner: staff, status: FactoryGirl.create(:status, :waiting)
    on_hold_ticket = FactoryGirl.create :ticket, owner: staff, status: FactoryGirl.create(:status, :on_hold)
    completed_ticket = FactoryGirl.create :ticket, owner: staff, status: FactoryGirl.create(:status, :completed)
    cancelled_ticket = FactoryGirl.create :ticket, owner: staff, status: FactoryGirl.create(:status, :cancelled)

    signin(staff.email, staff.password)

    [:unassigned, :open, :on_hold, :completed, :all]

    visit tickets_path
    expect(page).to have_content initial_ticket.sub_id
    expect(page).to have_content initial_ticket.sub_id
    expect(page).to have_content waiting_ticket.sub_id
    expect(page).to have_content on_hold_ticket.sub_id
    expect(page).to have_content completed_ticket.sub_id
    expect(page).to have_content cancelled_ticket.sub_id
    expect(page).to have_content unassigned_waiting_ticket.sub_id

    visit tickets_path(status: :unassigned)
    expect(page).to have_no_content initial_ticket.sub_id
    expect(page).to have_no_content waiting_ticket.sub_id
    expect(page).to have_no_content on_hold_ticket.sub_id
    expect(page).to have_no_content completed_ticket.sub_id
    expect(page).to have_no_content cancelled_ticket.sub_id
    expect(page).to have_content unassigned_waiting_ticket.sub_id

    visit tickets_path(status: :open)
    expect(page).to have_content initial_ticket.sub_id
    expect(page).to have_content waiting_ticket.sub_id
    expect(page).to have_no_content on_hold_ticket.sub_id
    expect(page).to have_no_content completed_ticket.sub_id
    expect(page).to have_no_content cancelled_ticket.sub_id
    expect(page).to have_content unassigned_waiting_ticket.sub_id

    visit tickets_path(status: :on_hold)
    expect(page).to have_no_content initial_ticket.sub_id
    expect(page).to have_no_content waiting_ticket.sub_id
    expect(page).to have_content on_hold_ticket.sub_id
    expect(page).to have_no_content completed_ticket.sub_id
    expect(page).to have_no_content cancelled_ticket.sub_id
    expect(page).to have_no_content unassigned_waiting_ticket.sub_id

    visit tickets_path(status: :completed)
    expect(page).to have_no_content initial_ticket.sub_id
    expect(page).to have_no_content waiting_ticket.sub_id
    expect(page).to have_no_content on_hold_ticket.sub_id
    expect(page).to have_content completed_ticket.sub_id
    expect(page).to have_content cancelled_ticket.sub_id
    expect(page).to have_no_content unassigned_waiting_ticket.sub_id

  end

end



require 'rails_helper'

RSpec.describe TicketHistory, type: :model do

  describe "#owner_name" do
    context "No owner" do
      let(:ticket_history) { FactoryGirl.create :ticket_history, owner: nil }

      subject { ticket_history.owner_name }

      it { should eql "None" }
    end

    context "With owner" do
      let!(:owner) { FactoryGirl.create :user }
      let(:ticket_history) { FactoryGirl.create :ticket_history, owner: owner }

      subject { ticket_history.owner_name }

      it { should eql owner.name }
    end
  end
end

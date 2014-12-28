require 'rails_helper'

RSpec.describe Ticket, type: :model do
  it { should validate_presence_of :sub_id }
  it { should validate_presence_of :customer_name  }
  it { should validate_presence_of :customer_email }
  it { should validate_presence_of :subject }
  it { should validate_presence_of :message }

  describe "initial status" do
    let!(:initial_status) { FactoryGirl.create :status, flag: :initial }
    let(:ticket) { FactoryGirl.create :ticket }

    subject { ticket.status }

    it { should eql initial_status }
  end

  describe "#owner_name" do
    context "No owner" do
      let(:ticket) { FactoryGirl.create :ticket, owner: nil }

      subject { ticket.owner_name }

      it { should eql "None" }
    end

    context "With owner" do
      let(:owner) { FactoryGirl.create :user }
      let(:ticket) { FactoryGirl.create :ticket, owner: owner }

      subject { ticket.owner_name }

      it { should eql owner.name }
    end
  end

  describe "#set_owner!" do
    let(:ticket) { FactoryGirl.create :ticket }
    let(:user) { FactoryGirl.create :user }

    it "should change owner" do
      old_owner = ticket.owner

      ticket.set_owner! user

      expect(ticket.reload.owner).not_to eql old_owner
      expect(ticket.reload.owner).to eql user
    end
  end

  describe "#set_status!" do
    let(:ticket) { FactoryGirl.create :ticket }
    let(:status) { FactoryGirl.create :status }

    it "should change status" do
      old_status = ticket.status

      ticket.set_status! status

      expect(ticket.reload.status).not_to eql old_status
      expect(ticket.reload.status).to eql status
    end
  end

  describe "#to_param" do
    let(:ticket) { FactoryGirl.create :ticket }
    subject { ticket.to_param }

    it { should eql ticket.sub_id.to_s }
  end

  describe "sub_id" do
    it "should be unique" do
      FactoryGirl.create(:ticket)

      should validate_uniqueness_of :sub_id
    end

    describe "format" do
      subject { FactoryGirl.create(:ticket).sub_id }

      it { should match /[A-Z]{3}-[0-9A-F]{2}-[A-Z]{3}-[0-9A-F]{2}-[A-Z]{3}/ } # ABC-4F-ABC-8D-ABC
    end

  end
end

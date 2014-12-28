require 'rails_helper'

RSpec.describe User, type: :model do

  describe ".customer_user" do
    let(:user) { FactoryGirl.create :user, role: :customer }

    subject { User.customer_user }

    it { should eql user }
  end

  describe "#can_edit?" do
    context "admin" do
      let(:user) { FactoryGirl.create :user, role: :admin }

      subject { user.can_edit? }

      it { should be true }
    end

    context "staff" do
      let(:user) { FactoryGirl.create :user, role: :staff }

      subject { user.can_edit? }

      it { should be true }
    end

    context "customer" do
      let(:user) { FactoryGirl.create :user, role: :customer }

      subject { user.can_edit? }

      it { should be false }
    end
  end

end

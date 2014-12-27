require 'rails_helper'

RSpec.describe Ticket, type: :model do
  it { should validate_presence_of :sub_id }
  it { should validate_presence_of :customer_name  }
  it { should validate_presence_of :customer_email }
  it { should validate_presence_of :subject }
  it { should validate_presence_of :message }

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

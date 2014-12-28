require 'rails_helper'

RSpec.describe Status, type: :model do

  it { should validate_presence_of :name }
  it { should validate_presence_of :flag }

  describe ".initial_status" do
    let(:status) { FactoryGirl.create :status, flag: :initial }

    subject { Status.initial_status }

    it { should eql status }
  end

end

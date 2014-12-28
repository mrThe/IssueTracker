require "rails_helper"

RSpec.describe TicketMailer, type: :mailer do
  describe "confirm" do
    let(:ticket) { FactoryGirl.create :ticket }
    let(:mail) { TicketMailer.confirm(ticket) }

    it "renders the headers" do
      expect(mail.subject).to eq "Ticket received!"
      expect(mail.to).to      eq [ticket.customer_email]
      expect(mail.from).to    eq ["from@example.com"]
    end

    context "body" do
      subject { mail.body.encoded }

      it { should include ticket_url(ticket) }
    end
  end

  describe "notify" do
    let(:ticket_history) { FactoryGirl.create :ticket_history }
    let(:mail) { TicketMailer.notify(ticket_history) }

    it "renders the headers" do
      expect(mail.subject).to eq "Ticket updated!"
      expect(mail.to).to      eq [ticket_history.ticket.customer_email]
      expect(mail.from).to    eq ["from@example.com"]
    end

    context "body" do
      subject { mail.body.encoded }

      it { should include ticket_url(ticket_history.ticket) }
      it { should include ticket_history.message }
    end
  end

end

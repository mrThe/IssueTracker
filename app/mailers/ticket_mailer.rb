class TicketMailer < ActionMailer::Base
  default from: "from@example.com"

  def confirm(ticket)
    @ticket = ticket

    mail to: ticket.customer_email
  end

  def notify(ticket_history)
    @ticket_history = ticket_history
    @ticket = ticket_history.ticket

    mail to: @ticket.customer_email
  end
end

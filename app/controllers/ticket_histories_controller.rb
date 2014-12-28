class TicketHistoriesController < ApplicationController
  before_action :set_ticket

  respond_to :html

  def create
    if user_signed_in? && current_user.can_edit?
      create_by_staff
    else
      create_by_customer
    end

    flash[:error] = @ticket_history.errors.full_messages.join(', ') unless @ticket.valid?

    redirect_to @ticket
  end

  def create_by_customer
    @ticket_history = @ticket.ticket_histories.new(user_ticket_params)
    @ticket_history.user = User.customer_user
    @ticket_history.status = Status.initial_status

    @ticket_history.save
  end

  def create_by_staff
    @ticket_history = @ticket.ticket_histories.new(ticket_params)
    @ticket_history.user = current_user

    TicketMailer.notify(@ticket_history).deliver if @ticket_history.save
  end

  private

  def set_ticket
    @ticket = Ticket.find_by! sub_id: params[:ticket_sub_id]
  end

  def ticket_params
    params.require(:ticket_history).permit(:message, :status_id, :owner_id)
  end

  def user_ticket_params
    params.require(:ticket_history).permit(:message)
  end
end

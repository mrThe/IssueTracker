class TicketHistoriesController < ApplicationController
  before_action :set_ticket

  respond_to :html

  def create
    if current_user && current_user.can_edit?
      @ticket_history = @ticket.ticket_histories.new(ticket_params)
      @ticket_history.user = current_user

      if @ticket_history.save
        TicketMailer.notify(@ticket_history).deliver
      end
    else
      @ticket_history = @ticket.ticket_histories.new(user_ticket_params)
      @ticket_history.user = User.customer_user
      @ticket_history.status = Status.initial_status

      @ticket_history.save
    end

    redirect_to @ticket
  end

  private

  def set_ticket
    @ticket = Ticket.find_by! sub_id: params[:ticket_sub_id]
  end

  def ticket_params
    params.require(:ticket_history).permit(:message, :status_id, :take_ownership)
  end

  def user_ticket_params
    params.require(:ticket_history).permit(:message)
  end
end

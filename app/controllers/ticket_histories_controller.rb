class TicketHistoriesController < ApplicationController
  before_action :set_ticket
  before_filter :authenticate_user!

  respond_to :html

  def create
    @ticket_history = @ticket.ticket_histories.new(ticket_params)
    @ticket_history.user = current_user

    if @ticket_history.save
      TicketMailer.notify(@ticket_history).deliver
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
end

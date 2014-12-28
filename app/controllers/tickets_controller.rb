class TicketsController < ApplicationController
  before_action :set_ticket, only: [:show, :update]
  before_filter :authenticate_user!, only: [:index, :update]

  respond_to :html

  def index
    @tickets = Ticket.send(determine_scope).search(params[:search]).order(:created_at)
  end

  def show
    @ticket_history = TicketHistory.new
  end

  def new
    @ticket = Ticket.new
  end

  def create
    @ticket = Ticket.new(ticket_params)
    if @ticket.save
      TicketMailer.confirm(@ticket).deliver
      redirect_to @ticket
    else
      render :new
    end
  end

  def update
    @ticket.update(ticket_params)
  end

  private

  def determine_scope
    scope = params[:status].try(:to_sym) || :all
    [:unassigned, :open, :on_hold, :completed, :all].include?(scope) ? scope : :all
  end

  def set_ticket
    @ticket = Ticket.includes(:ticket_histories).find_by! sub_id: params[:sub_id]
  end

  def ticket_params
    params.require(:ticket).permit(:customer_name, :customer_email, :subject, :message)
  end
end

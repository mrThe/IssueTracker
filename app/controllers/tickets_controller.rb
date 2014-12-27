class TicketsController < ApplicationController
  before_action :set_ticket, only: [:show, :edit, :update]
  before_filter :authenticate_user!, only: [:index, :edit, :update]

  respond_to :html

  def index
    @tickets = Ticket.all
  end

  def show
  end

  def new
    @ticket = Ticket.new
  end

  def edit
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

  def set_ticket
    @ticket = Ticket.find_by! sub_id: params[:sub_id]
  end

  def ticket_params
    params.require(:ticket).permit(:customer_name, :customer_email, :subject, :message)
  end
end

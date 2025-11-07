class AppointmentsController < ApplicationController
  
  def index
    @appointments = current_user.appointments
  end
  
  def show
  end

  def new
    @client = current_user.clients.find(params[:client_id])
    @appointment = current_user.appointments.new(client: @client)
  end

  def create
    @appointment = current_user.appointments.build(appointment_params)
    if @appointment.save
      redirect_to client_appointment_url(id: @appointment.id), notice: 'Appointment was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
  end

  def destory
  end

  private
    def appointment_params
      params.require(:appointment).permit(:client_id, :scheduled_at, :location, :status)
    end
end

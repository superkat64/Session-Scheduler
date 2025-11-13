class AppointmentsController < ApplicationController
  before_action :set_client, only: %i[index show new create]
  before_action :set_appointment, only: %i[show edit update destroy]

  def index
    @appointments = @client.appointments
  end

  def show
  end

  def new
    @appointment = @client.appointments.build
  end

  def create
    @appointment = @client.appointments.build(appointment_params)
    if @appointment.save!
      redirect_to appointment_path(@appointment), notice: "Appointment was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @appointment.update!(appointment_params)
      redirect_to appointment_path(@appointment), notice: "Appointment was successfully updated."
    else

      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    client_id = @appointment.client_id
    @appointment.destroy
    redirect_to client_appointments_path(client_id), notice: "Appointment was successfully deleted."
  end

  private

    def set_client
      @client = Client.find(params[:client_id]) if params[:client_id]
    end

    def set_appointment
      @appointment = Appointment.find(params[:id])
    end

    def appointment_params
      params.require(:appointment).permit(:scheduled_at, :location, :status, :duration_minutes)
    end
end

class NotesController < ApplicationController
  before_action :set_appointment, only: %i[ new create]
  before_action :set_note, only: %i[show edit update destroy]

  def show
  end

  def new
    @note = @appointment.notes.build
  end

  def create
    @note = @appointment.notes.build(note_params)
    if @note.save
      redirect_to appointment_path(@appointment), notice: "Note was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @note.update(note_params)
      redirect_to appointment_path(@note.appointment), notice: "Note was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    appointment = @note.appointment
    @note.destroy
    redirect_to appointment_path(appointment), notice: "Note was successfully deleted."
  end

  private

    def set_appointment
      @appointment = Appointment.find(params[:appointment_id])
    end

    def set_note
      @note = Note.find(params[:id])
    end

    def note_params
      params.require(:note).permit(:content)
    end
end

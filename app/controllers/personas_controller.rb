class PersonasController < ApplicationController
  before_action :set_persona, only: %i[ show edit update destroy ]

  def index
    authorize Persona
    @personas = policy_scope(Persona)
  end

  def show
    authorize @persona
  end

  def new
    @persona = Persona.new
    authorize @persona
  end

  def edit
    authorize @persona
  end

  def create
    authorize Persona

    @persona = Persona.new(persona_params)
    email = params[:email]

    ActiveRecord::Base.transaction do
      @persona.save!

      random_password = SecureRandom.hex(16)

      user = User.create!(
        email_address: email,
        persona: @persona,
        password: random_password,
        password_confirmation: random_password
      )

      PasswordsMailer.reset(user).deliver_later
    end

    respond_to do |format|
      format.html { redirect_to @persona, notice: "Persona creada con éxito. Se ha enviado un correo de invitación para configurar la cuenta." }
      format.json { render :show, status: :created, location: @persona }
    end
  rescue ActiveRecord::RecordInvalid => e
    flash.now[:alert] = e.record.errors.full_messages.to_sentence
    respond_to do |format|
      format.html { render :new, status: :unprocessable_entity }
      format.json { render json: { errors: e.record.errors.full_messages }, status: :unprocessable_entity }
    end
  end

  def update
    authorize @persona
    respond_to do |format|
      if @persona.update(persona_params)
        format.html { redirect_to @persona, notice: "Persona was successfully updated.", status: :see_other }
        format.json { render :show, status: :ok, location: @persona }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @persona.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    authorize @persona
    @persona.destroy!

    respond_to do |format|
      format.html { redirect_to personas_path, notice: "Persona was successfully destroyed.", status: :see_other }
      format.json { head :no_content }
    end
  end

  private
    def set_persona
      @persona = Persona.find(params[:id])
    end

    def persona_params
      params.require(:persona).permit(:nombre, :apellido)
    end
end

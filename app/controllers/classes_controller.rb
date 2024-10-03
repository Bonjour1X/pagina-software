# app/controllers/classes_controller.rb
class ClassesController < ApplicationController
  before_action :authenticate_user!

  def index
    @classes = Class.all
  end

  def show
    @class = Class.find(params[:id])
    @evaluation = Evaluation.new
    @enrollment_request = EnrollmentRequest.new
  end

  def new
    @clase = Class.new
  end

  def create
    @class = current_user.classes.build(class_params)
    if @class.save
      redirect_to @class, notice: 'Clase creada exitosamente.'
    else
      render :new
    end
  end

  def my_classes
    @classes = current_user.clases
  end

  def available_classes
    @classes = Clase.where.not(user: current_user)
  end

  private

  def class_params
    params.require(:class).permit(:title, :description, :scheduled_date, :materials, :modality)
  end
end
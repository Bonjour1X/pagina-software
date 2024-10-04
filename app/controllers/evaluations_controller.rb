# app/controllers/evaluations_controller.rb
class EvaluationsController < ApplicationController
  def new
    @course = Course.find(params[:course_id])
    @evaluation = @course.evaluations.new
  end

  def create
    @course = Course.find(params[:course_id])
    @evaluation = @course.evaluations.new(evaluation_params)
    if @evaluation.save
      redirect_to @course, notice: 'Evaluación creada exitosamente.'
    else
      render :new
    end
  end

  private

  def evaluation_params
    params.require(:evaluation).permit(:name, :evaluation_method, :start_date, :end_date)
  end
end
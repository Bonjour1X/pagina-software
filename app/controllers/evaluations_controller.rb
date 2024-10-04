# app/controllers/evaluations_controller.rb
class EvaluationsController < ApplicationController
  def new
    @course = Course.find(params[:course_id])
    @evaluation = @course.evaluations.new
  end

  def create
    @course = Course.find(params[:course_id])
    @evaluation = @course.evaluations.build(evaluation_params)
    if @evaluation.save
      redirect_to @course, notice: 'Evaluación creada exitosamente.'
    else
      render :new
    end
  end

  def edit
    @course = Course.find(params[:course_id])
    @evaluation = @course.evaluations.find(params[:id])
  end
  
  def update
    @course = Course.find(params[:course_id])
    @evaluation = @course.evaluations.find(params[:id])
    if @evaluation.update(evaluation_params)
      redirect_to @course, notice: 'Evaluación actualizada exitosamente.'
    else
      render :edit
    end
  end

  private

  def evaluation_params
    params.require(:evaluation).permit(:name, :questions, :solution, :evaluation_method)
  end
end
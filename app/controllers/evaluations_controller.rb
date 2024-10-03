# app/controllers/evaluations_controller.rb
class EvaluationsController < ApplicationController
  def create
    @course = Course.find(params[:course_id])
    @evaluation = @course.evaluations.build(evaluation_params)
    if @evaluation.save
      redirect_to @course, notice: 'Evaluación creada exitosamente.'
    else
      render :new
    end
  end

  # Eliminar Evaluaciones
  def destroy
    @evaluation = Evaluation.find(params[:id])
    @course = @evaluation.course
    @evaluation.destroy
    redirect_to @course, notice: 'Evaluación eliminada exitosamente.'
  end

  private

  def evaluation_params
    params.require(:evaluation).permit(:name, :questions, :solution, :evaluation_method)
  end

end
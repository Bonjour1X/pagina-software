# app/controllers/evaluations_controller.rb
class EvaluationsController < ApplicationController
    before_action :authenticate_user!
  
    def new
      @class = Class.find(params[:class_id])
      @evaluation = @class.evaluations.new
    end
  
    def create
      @class = Class.find(params[:class_id])
      @evaluation = @class.evaluations.build(evaluation_params)
      if @evaluation.save
        redirect_to @class, notice: 'Evaluación creada exitosamente.'
      else
        render :new
      end
    end
  
    private
  
    def evaluation_params
      params.require(:evaluation).permit(:name, :questions, :solution, :evaluation_method)
    end
  end
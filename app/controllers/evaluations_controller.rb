class EvaluationsController < ApplicationController

  before_action :set_course
  before_action :set_evaluation, only: [:show, :edit, :update, :destroy, :student_results]

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

  def show
    @course = Course.find(params[:course_id])
    @evaluation = @course.evaluations.includes(:questions).find(params[:id])
  end
  
  def edit
    @course = Course.find(params[:course_id])
    @evaluation = @course.evaluations.find(params[:id])
    @evaluation.questions.build if @evaluation.questions.empty?
  end
  
  def destroy
    @course = Course.find(params[:course_id])
    @evaluation = @course.evaluations.find(params[:id])
    if @evaluation.destroy
      redirect_to @course, notice: 'Evaluación eliminada exitosamente.'
    else
      redirect_to @course, alert: 'No se pudo eliminar la evaluación.'
    end
  end

  def update
    @course = Course.find(params[:course_id])
    @evaluation = @course.evaluations.find(params[:id])
  
    if @evaluation.update(evaluation_params)
      redirect_to course_path(@course), notice: 'Evaluación actualizada exitosamente.'
    else
      render :edit
    end
  end
  
  

  def show_results
    @evaluation = @course.evaluations.find(params[:id])
    @enrolled_students = @course.enrolled_users
    @student_answers = {}

    @enrolled_students.each do |student|
      @student_answers[student.id] = {
        status: evaluation_status(student, @evaluation),
        answers: student_evaluation_answers(student, @evaluation),
        grade: get_student_grade(student, @evaluation)
      }
    end
  end

  def student_results
    @enrolled_students = @course.enrolled_users
    @student_grades = {}
    
    @enrolled_students.each do |student|
      @student_grades[student.id] = {
        status: evaluation_status(student),
        grade: Grade.find_by(student: student, evaluation: @evaluation)&.score || 0.0
      }
    end
  end
  
  def show_answer
    @course = Course.find(params[:course_id])
    @evaluation = @course.evaluations.find(params[:id])
    @student = User.find(params[:student_id])
    
    # Cargar todas las respuestas del estudiante para esta evaluación
    @student_responses = StudentResponse.where(
      user: @student,
      question_id: @evaluation.questions.pluck(:id)
    ).index_by(&:question_id)
  end
  
  def update_grade
    @evaluation = @course.evaluations.find(params[:id])
    @student = User.find(params[:student_id])
    
    grade = Grade.find_or_initialize_by(
      student: @student,
      evaluation: @evaluation
    )
    grade.score = params[:score]
    
    if grade.save
      redirect_to student_results_course_evaluation_path(@course, @evaluation), 
                  notice: 'Nota actualizada correctamente'
    else
      redirect_to student_results_course_evaluation_path(@course, @evaluation), 
                  alert: 'Error al actualizar la nota'
    end
  end

  def grade_question
    @question = @evaluation.questions.find(params[:question_id])
    # Aquí iría la lógica para guardar la nota
    redirect_to show_answers_course_evaluation_path(@course, @evaluation), notice: 'Calificación guardada'
  end

  def save_changes
    @evaluation = @course.evaluations.find(params[:id])
    
    ActiveRecord::Base.transaction do
      params[:questions].each do |question_data|
        if question_data[:id].present?
          question = @evaluation.questions.find(question_data[:id])
          if question_data[:deleted]
            question.destroy
          else
            question.update!(
              content: question_data[:content],
              question_type: question_data[:question_type]
            )
          end
        else
          @evaluation.questions.create!(
            content: question_data[:content],
            question_type: question_data[:question_type]
          )
        end
      end
    end
  
    render json: { success: true }
  rescue => e
    render json: { success: false, error: e.message }
  end

  def save_answer
    @question = Question.find(params[:question_id])
    @response = StudentResponse.find_or_initialize_by(
      user: current_user,
      question: @question
    )
    @response.content = params[:content]
  
    if @response.save
      render json: { status: 'success' }
    else
      render json: { status: 'error', message: @response.errors.full_messages }, 
             status: :unprocessable_entity
    end
  end
  
  private
  
  def set_course
    @course = Course.find(params[:course_id])
  end

  def set_evaluation
    @evaluation = @course.evaluations.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    redirect_to course_path(@course), alert: 'Evaluación no encontrada'
  end

  def evaluation_status(_student)
    if Time.current < @evaluation.start_date
      'Pendiente'
    elsif Time.current > @evaluation.end_date
      'Finalizada'
    else
      'En curso'
    end
  end

  def evaluation_params
    params.require(:evaluation).permit(
      :name,
      :evaluation_method,
      :start_date,
      :end_date,
      questions_attributes: [
        :id, 
        :content, 
        :question_type,
        :_destroy,
        alternatives: [],
        alternatives_correct: []
      ]
    )
  end
  
end
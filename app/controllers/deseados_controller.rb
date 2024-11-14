class DeseadosController < ApplicationController

    def index
        @deseados = current_user.clases_deseadas 
    end

    def available_deseados
        @deseados = Deseados.where.not(id: current_user.enrolled_courses.pluck(:id))
                         .where.not(user: current_user)
    end

    def add_to_favorites
        @course = Course.find(params[:id])
        if current_user.clases_deseadas.exists?(id: @course.id)
            flash[:notice] = "Este curso ya está en tu lista de deseos."
        else
            current_user.deseados.create(course: @course)
            redirect_to @course
        end
    end

    def eliminar_favorites
        @course = Course.find(params[:id])
        deseado = current_user.deseados.find_by(course: @course)
    
        if deseado
          deseado.destroy
        end
        redirect_to @course
    end
end
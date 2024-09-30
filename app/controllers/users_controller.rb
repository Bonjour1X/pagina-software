class UsersController < ApplicationController
    def index
        @users = User.all
      end
    
    def show
        
        @users = User.all
      end


    def destroy
        @user = current_user
        if @user.destroy
            sign_out @user
            redirect_to root_path, alert: 'Tu cuenta ha sido eliminada.'
        else
            redirect_to root_path, alert: 'No se pudo eliminar tu cuenta.'
      end
    end
end

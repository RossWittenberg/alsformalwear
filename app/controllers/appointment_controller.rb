class AppointmentController < ApplicationController
	
	def delete
		@appointment = Appointment.find params[:id]
    if params[:admin] && @appointment.present?
      @appointment.destroy
      params[:tabtag].present? ? tabtag = params[:tabtag] : tabtag = "appointments"
      flash.now[:success] = "Appointment has been deleted"
      redirect_to "/catalog/admin/leads#"+"#{tabtag}"
    else

    end
	end
end
class RegistrationsController < Devise::RegistrationsController


  private

  def sign_up_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation, :gender,  :institution, :phone, :address, :country, :bio, :web_site, :speciality )
  end

  def account_update_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation, :current_password, :gender,  :institution, :phone, :address, :country, :bio, :web_site, :speciality)
  end
end

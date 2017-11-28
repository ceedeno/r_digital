class RegistrationsController < Devise::RegistrationsController


  def new
    super do |resource|
      resource.build_profile
    end
  end

  private

  def sign_up_params
    params.require(:user).permit(:first_name, :email, :password, :password_confirmation, profile_attributes: [:id, :last_name, :gender,  :institution, :phone, :address, :country, :bio, :web_site, :speciality] )
  end

  def account_update_params
    params.require(:user).permit(:first_name, :email, :password, :password_confirmation, :current_password, profile_attributes: [:id, :last_name, :gender,  :institution, :phone, :address, :country, :bio, :web_site, :speciality])
  end
end

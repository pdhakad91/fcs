class RegistrationsController < Devise::RegistrationsController

  def new
    @match_code = SecretCode.where(:user_id => nil).first
    super
  end

  def create
    build_resource(sign_up_params)
    if resource.save
      sign_up(resource_name, resource)
      respond_with resource, :location => after_sign_up_path_for(resource)
    else
      clean_up_passwords resource
      @match_code = SecretCode.where(:user_id => nil).first
      flash[:error] = resource.errors.full_messages.join("<br/>").html_safe
      render :new
    end
  end
  
end 

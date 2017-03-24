class SecretCodesController < ApplicationController
  authorize_resource

  def index
    @secret_codes = SecretCode.all
  end

  def new
    respond_to do |format|
      format.js{
        @generated_codes = []
        (params[:count].to_i).times{ @generated_codes.push(SecureRandom.hex(4)) }
      }
    end
  end

  def create
    respond_to do |format|
      format.js{
        params[:values].split(",").each do |code|
          SecretCode.create(:code => code)
        end
        render :js => "window.location = '/secret_codes/'"
      }
    end
  end
end

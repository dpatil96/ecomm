# frozen_string_literal: true

class ProfilesController < ApplicationController
  before_action :set_profile, only: %i[edit update]

  def edit; end

  def update
    if @profile.update(profile_params)
      redirect_to root_path, notice: 'Profile was successfully updated.'
    else
      render :edit
    end
  end

  private

  def set_profile
    @profile = current_user.profile || current_user.build_profile
  end

  def profile_params
    params.require(:profile).permit(:name)
  end
end

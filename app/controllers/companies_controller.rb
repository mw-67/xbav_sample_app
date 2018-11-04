class CompaniesController < SharedController
  cattr_accessor :model_klass
  self.model_klass = Company

  private

  def permitted_params
    params[:company].permit(:name)
  end
end

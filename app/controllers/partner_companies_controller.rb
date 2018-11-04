class PartnerCompaniesController < SharedController
  cattr_accessor :model_klass
  self.model_klass = PartnerCompany

  private

  def permitted_params
    params[:company].permit(:name)
  end
end

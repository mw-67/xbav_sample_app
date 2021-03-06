class PartnerCompaniesController < SharedController
  cattr_accessor :model_klass
  self.model_klass = PartnerCompany

  private

  def permitted_params
    params[:partner_company].permit(:name)
  end
end

class ContractorsController < SharedController
  cattr_accessor :model_klass
  self.model_klass = Contractor

  private

  def scope
    scope = Contractor
    if params[:company_id]
      scope = Company.find(params[:company_id]).contractors
    elsif params[:partner_company_id]
      scope = PartnerCompany.find(params[:partner_company_id]).contractors
    end
    scope
  end

  def permitted_params
    params[:contractor].permit(:first_name, :last_name, :partner_company_id)
  end
end

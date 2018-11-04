class ClientsController < SharedController
  cattr_accessor :model_klass
  self.model_klass = Client

  private

  def scope
    scope = Client
    if params[:company_id]
      scope = Company.find(params[:company_id]).clients
    elsif params[:partner_company_id]
      scope = PartnerCompany.find(params[:partner_company_id]).clients
    elsif params[:employee_id]
      scope = Employee.find(params[:employee_id]).clients
    end
    scope
  end

  def permitted_params
    params[:client].permit(:first_name, :last_name)
  end
end

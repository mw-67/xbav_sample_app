class EmployeesController < SharedController
  cattr_accessor :model_klass
  self.model_klass = Employee

  private

  def scope
    scope = Employee
    if params[:company_id]
      scope = scope.where(company_id: params[:company_id])
    end
    scope
  end

  def permitted_params
    params[:employee].permit(:first_name, :last_name, :company_id)
  end
end

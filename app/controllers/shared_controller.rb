class SharedController < ApplicationController
  before_action :authenticate_user!

  before_action :load_instance, except: [:index, :new, :create]

  helper_method :current_user

  def index
    @collection = scope.order(:id).all
  end

  def show
  end

  def new
    @instance = model_klass.new
    render :edit
  end

  def create
    @instance = model_klass.new
    update
  end

  def edit
  end

  def update
    @instance.update_attributes(permitted_params)
    if @instance.save
      redirect_to show_path
    else
      render :edit
    end
  end

  def destroy
    if @instance.deletable?
      @instance.destroy
      redirect_to list_path
    else
      flash[:alert] = 'cannot delete. fix dependecies first.'
      redirect_to show_path
    end
  end

  private

  def current_user
    session[:user]
  end

  def load_instance
    @instance = model_klass.find(params[:id])
  end

  def scope
    model_klass
  end

  def show_path
    send(model_klass.name.underscore + '_path', id: @instance.id)
  end

  def list_path
    send(model_klass.name.underscore.pluralize + '_path')
  end
end

class ResourcesController < ApplicationController
  before_action :authenticate_account!, except: :show
  before_action :set_resource, only: %i[show edit update destroy]

  def index
    @resources = Resource.all
  end

  def show
  end

  def new
    @resource = Resource.new
  end

  def edit
    @resource = Resource.includes(:resource_category).find(params[:id])
    @category_fields = render_to_string(partial: "resources/category_fields", locals: { form: form_builder, resource: @resource })
  end

  def create
    @resource = current_account.resources.build(resource_params)

    respond_to do |format|
      if @resource.save
        format.html { redirect_to resource_url(@resource), notice: "Resource was successfully created." }
        format.json { render :show, status: :created, location: @resource }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @resource.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @resource.update(resource_params)
        format.html { redirect_to resource_url(@resource), notice: "Resource was successfully updated." }
        format.json { render :show, status: :ok, location: @resource }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @resource.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @resource.destroy!
    respond_to do |format|
      format.html { redirect_to resources_url, notice: "Resource was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def category_fields
    @category = ResourceCategory.find(params[:category_id])
    @resource = Resource.new(resource_category: @category)
    
    render turbo_stream: turbo_stream.update("category_specific_fields", 
      partial: "resources/category_fields", 
      locals: { form: ActionView::Helpers::FormBuilder.new(:resource, @resource, view_context, {}), resource: @resource }
    )
  end

  private

  def set_resource
    @resource = Resource.find(params[:id])
  end

  def resource_params
    params.require(:resource).permit(:title, :description, :youtube_id, :resource_category_id, :cover_image, :file, :audio)
  end

  def form_builder
    ActionView::Helpers::FormBuilder.new(:resource, @resource, view_context, {})
  end
end

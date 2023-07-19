class OperationsController < ApplicationController  
  before_action :set_operation, only: %i[show edit update destroy]
  before_action :set_locale, only: [:create, :update]

  # GET /operations or /operations.json
  def index
    @operations = filtered_operations.page(params[:page])
  end

  # GET /operations/1 or /operations/1.json
  def show
  end

  # GET /operations/new
  def new
    @operation = Operation.new
  end

  # GET /operations/1/edit
  def edit
  end

  # POST /operations or /operations.json
  def create
    @operation = Operation.new(operation_params)

    respond_to do |format|
      if @operation.save
        format.html { redirect_to operation_url(@operation), notice: 'Транзакцію успішно створено.' }
        format.json { render :show, status: :created, location: @operation }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @operation.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /operations/1 or /operations/1.json
  def update
    respond_to do |format|
      if @operation.update(operation_params)
        format.html { redirect_to operation_url(@operation), notice: 'Транзакцію успішно оновлено.' }
        format.json { render :show, status: :ok, location: @operation }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @operation.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /operations/1 or /operations/1.json
  def destroy
    @operation.destroy

    respond_to do |format|
      format.html { redirect_to operations_url, notice: 'Транзакцію успішно видалено.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_operation
    @operation = Operation.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def operation_params
    params.require(:operation).permit(:amount, :odate, :description, :category_id, :operation_type_id)
  end

  def filtered_operations
    @category_id = params[:category_id]

    operations = Operation.all
    operations = operations.where(category_id: @category_id) if @category_id.present?
    operations
  end

  def set_locale
    I18n.locale = :uk
  end
end

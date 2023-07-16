class ReportsController < ApplicationController
  before_action :set_report_variables, only: %i[index report_by_category report_by_dates]

  def index
    reset_report_params
  end

  def report_by_category
    return unless @start_date.present? && @end_date.present?

    @report_data = fetch_amounts_by_category.map { |category, amount| [category.name, amount] }
    extract_report_values(@report_data)
  end

  def report_by_dates
    return unless @start_date.present? && @end_date.present?

    report_data = fetch_amounts_by_date.map { |date, amount| [date.to_date.to_s, amount] }
    extract_report_values(report_data)
  end

  private

  def set_report_variables
    @start_date = params[:start_date]
    @end_date = params[:end_date]
    @operation_type_id = params[:operation_type_id]
    @category_id = params[:category_id]

    @operation_type_name = OperationType.find_by(id: @operation_type_id)&.name
    @operation_type_case = @operation_type_name == 'дохід' ? 'доходів' : 'витрат' if @operation_type_name.present?
  end

  def reset_report_params
    start_date = ''
    end_date = ''
    operation_type_id = ''
    category_id = ''
  end

  def fetch_amounts_by_category
    fetch_operation_amounts.group(:category).sum(:amount)
  end

  def fetch_amounts_by_date
    fetch_operation_amounts.group(:odate).sum(:amount)
  end

  def fetch_operation_amounts
    Operation.joins(:operation_type, :category)
             .where(odate: @start_date..@end_date)
             .where(operation_type_conditions)
             .where(category_conditions)
  end

  def operation_type_conditions
    @operation_type_id.present? ? { operation_types: { id: @operation_type_id } } : {}
  end

  def category_conditions
    @category_id.present? ? { categories: { id: @category_id } } : {}
  end

  def extract_report_values(report_data)
    @items = report_data.map(&:first)
    @amounts = report_data.map(&:second)
    @total = @amounts.reduce(0) { |acc, cur| acc + cur }
  end
end

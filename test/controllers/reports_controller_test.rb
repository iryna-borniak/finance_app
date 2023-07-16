require 'test_helper'

class ReportsControllerTest < ActionDispatch::IntegrationTest
  test 'should get index' do
    get reports_index_url
    assert_response :success
  end

  test 'should get report_by_category' do
    get reports_index_url,
        params: {
          start_date: '2023-06-01',
          end_date: '2023-07-01',
          operation_type_id: operation_types(:one).id,
          category_id: categories(:cat_1).id
        }

    get reports_report_by_category_url

    assert_response :success
    if request.params[:start_date].present? && request.params[:end_date].present?
      assert_equal ['1st_Category'], assigns(:items)
      assert_equal [1000], assigns(:amounts)
      assert_equal 1000, assigns(:total)
    else
      assert_nil assigns(:items)
      assert_nil assigns(:amounts)
      assert_nil assigns(:total)
    end
  end

  test 'should get report_by_dates' do
    get reports_index_url,
        params: {
          start_date: '2023-06-01',
          end_date: '2023-07-01',
          operation_type_id: operation_types(:one).id,
          category_id: categories(:cat_1).id
        }

    get reports_report_by_dates_url

    assert_response :success
    if request.params[:start_date].present? && request.params[:end_date].present?
      assert_equal %w[2023-06-01 2023-07-01], assigns(:items)
      assert_equal [100, 900], assigns(:amounts)
      assert_equal 1000, assigns(:total)
    else
      assert_nil assigns(:items)
      assert_nil assigns(:amounts)
      assert_nil assigns(:total)
    end
  end
end

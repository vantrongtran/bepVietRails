module Admin::CategoriesHelper
  def reder_form_category
    render("admin/categories/modal_edit_categories")
    render("admin/categories/modal_new_categories")
  end
end

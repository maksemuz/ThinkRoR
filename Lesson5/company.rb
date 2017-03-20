module Company

  def set_company(company_name)
    @company ||= company_name
  end

  def get_company
    @company
  end

end
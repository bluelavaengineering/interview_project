module ApplicationHelper

  def year
    # it's been years since I've not used something like graphql or jsonapi for
    # data ingress, I typically rely on those standards and filtering for xss
    # protection. This will work in a pinch. The other way I tried was silly.
    @year.to_i
  end

  def population
    @population
  end

end

module Checkable
  def alphabetic? value
    value.match?(/\A[a-zA-Z]+\z/)
  end
end

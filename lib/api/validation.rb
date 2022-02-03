class MinLength < Grape::Validations::Base
  def validate_param!(attr_name, params)
    unless params[attr_name].length > @option
      fail Grape::Exceptions::Validation, params: [@scope.full_name(attr_name)], message: "must be atleast #{@option} characters long"
    end
  end
end

class Alpha < Grape::Validations::Base
  def validate_param!(attr_name, params)
    unless params[attr_name] =~ /\A[[:alpha:]]+\z/
      fail Grape::Exceptions::Validation, params: [@scope.full_name(attr_name)], message: 'must consist of alphabets '
    end
  end
end


class Email < Grape::Validations::Base
  def validate_param!(attr_name, params)
    unless params[attr_name] =~ /.+@.+/
      fail Grape::Exceptions::Validation, params: [@scope.full_name(attr_name)], message: 'format is incorrect '
    end
  end
end


class Mobile < Grape::Validations::Base
  def validate_param!(attr_name, params)
    unless params[attr_name] =~ /^(\+\d{1,3}[- ]?)?\d{10}$/
      fail Grape::Exceptions::Validation, params: [@scope.full_name(attr_name)], message: 'format is incorrect '
    end
  end
end
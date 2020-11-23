class ApplicationController < Panicboat::ApplicationController
  def _userdata(data, headers)
    return nil if data.blank?

    ::User.find_by(email: data.first['email'])
  end
end

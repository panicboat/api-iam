class ApplicationController < Panicboat::ApplicationController
  def _userdata(data)
    return nil if data.blank?

    ::User.find_by(email: data[0]['email'])
  end
end

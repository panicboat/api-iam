class ApplicationController < Panicboat::ApplicationController
  private

  def _run_options(ctx)
    headers = ::RequestHeader.new(request.headers)
    ctx.merge!({ headers: headers })
    ctx.merge!({ action: "#{ENV['AWS_ECS_SERVICE_NAME']}:#{_action}" })
    ctx.merge!({ current_user: _session(headers) })
  end

  def _action
    controller = request.controller_class.to_s.gsub(/Controller$/, '').singularize
    action = request.path_parameters[:action]
    case action
    when 'destroy' then "Delete#{controller.capitalize}"
    when 'index' then "List#{controller.capitalize}"
    when 'show' then "Get#{controller.capitalize}"
    else "#{action.capitalize}#{controller.capitalize}"
    end
  end

  def _session(headers)
    jwt = headers.authorization[::RequestHeader::USER_CLAIMS]
    return nil if jwt.blank?

    data = ::TokenManager.new(jwt).decode
    return nil if data.blank?

    ::User.find_by(email: data.first['email'])
  end
end

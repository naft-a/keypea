# frozen_string_literal: true

class RecordService

  def self.call(env)
    req = Rack::Request.new env
    res = Rack::Response.new

    if req.get? && req.path_info == "/"
      res.redirect("/core/v1/schema")
    end

    res.finish
  end

end

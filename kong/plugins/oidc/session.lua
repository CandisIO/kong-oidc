local utils = require("kong.plugins.oidc.utils")

local M = {}

function M.configure(config)
  if config.session_secret then
    local decoded_session_secret = ngx.decode_base64(config.session_secret)
    if not decoded_session_secret then
      utils.exit(500, "invalid OIDC plugin configuration, session secret could not be decoded", ngx.exit(ngx.HTTP_INTERNAL_SERVER_ERROR))
    end
    ngx.var.session_secret = decoded_session_secret
  end

  if config.session_cookie_domain then
    ngx.var.session_cookie_domain = config.session_cookie_domain
  end
end

return M

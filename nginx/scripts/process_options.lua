-- Check `Origin` header.
local origin = ngx.req.get_headers()['Origin']
if not origin then
  ngx.log(ngx.NOTICE, "No `Origin` headers.")
  ngx.exit(400)
end

-- Check `Access-Control-Request-Method` header.
local ac_method = ngx.req.get_headers()['Access-Control-Request-Method']
if not ac_method then
  ngx.log(ngx.NOTICE, "No `Access-Control-Request-Method` headers.")
  ngx.exit(400)
end
if AcceptMethods.is_accepted(ac_method)==nil then
  ngx.log(ngx.NOTICE, "Invalid `Access-Control-Request-Method`: ", ac_method)
  ngx.exit(400)
end
if not AcceptMethods.is_accepted(ac_method) then
  ngx.log(ngx.NOTICE, "Forbidden `Access-Control-Request-Method`: ", ac_method)
  ngx.exit(403)
end

-- build response.
ngx.status = 200;
ngx.header['Access-Control-Allow-Origin']  = origin
ngx.header['Access-Control-Allow-Methods'] = AcceptMethods.to_s()
ngx.header['Access-Control-Allow-Headers'] = ngx.req.get_headers()['Access-Control-Request-Headers']
ngx.header['Access-Control-Allow-Credentials'] = 'true'
ngx.header['Vary'] = 'Origin, Access-Control-Request-Headers, Access-Control-Request-Method'
ngx.exit(0)

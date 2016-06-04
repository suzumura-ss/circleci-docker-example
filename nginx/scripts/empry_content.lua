ngx.header['Content-Type'] = 'text/plain'
ngx.say(JSON.encode({resuest_id=ngx.var.request_uuid, application_version=ngx.var.application_version}))

ngx.header['Content-Type'] = 'text/plain'
ngx.say(JSON.encode({resuest_id=ngx.var.request_uuid}))

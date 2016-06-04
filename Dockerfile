# docker build --tag=front-nginx .
# and
# docker run --rm \
#   -v `pwd`/tmp:/var/log/nginx:rw \
#   -p 80:80 \
#   front-nginx

FROM suzumura/nginx-extras-with-cjson:16.04

WORKDIR /root
ENV TZ=GMT

# setup code.
RUN (cd /usr/share/nginx; mkdir scripts; ln -s /var/log/nginx logs)
COPY nginx/conf/nginx.conf /etc/nginx/nginx.conf
COPY nginx/html            /usr/share/nginx/html/
COPY nginx/scripts         /usr/share/nginx/scripts
ADD nginx/lib/16.04/5.1/lua_uuid.so /usr/lib/x86_64-linux-gnu/lua/5.1/
ADD nginx/launch.sh ./

# run.
CMD ["/usr/sbin/nginx", "-g", "daemon off;"]
VOLUME ["/var/log/nginx"]
EXPOSE 80

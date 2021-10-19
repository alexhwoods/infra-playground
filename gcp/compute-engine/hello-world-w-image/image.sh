CONTAINER_ID=$(docker run -P -d nginxdemos/hello)
URL="http://$(docker port $CONTAINER_ID | head -1 | awk '{ print $3 }')"

open $URL

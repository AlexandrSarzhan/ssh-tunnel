FROM alpine:3.9
RUN apk add --no-cache \
  openssh-client

ENV PORT=3000
ENV SRC_SSH_DATA="/root/src_ssh"
ENV DST_SSH_DATA="/root/.ssh"

EXPOSE $PORT

CMD rm -rf $DST_SSH_DATA \
  && mkdir $DST_SSH_DATA \
  && cp -r $SRC_SSH_DATA/* $DST_SSH_DATA/ \
  && chmod -R 600 $DST_SSH_DATA/* \
  && ssh \
    -N \
    -o StrictHostKeyChecking=no \
    -D 0.0.0.0:$PORT $UNAME@$SERVER_ADDR \
  && while true; do sleep 1000; done;

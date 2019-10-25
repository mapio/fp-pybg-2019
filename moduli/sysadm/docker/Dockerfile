FROM python:3.8-alpine

RUN apk add --no-cache --update openssh libzmq sudo rsync; \
    apk add --no-cache --virtual .build-deps gcc musl-dev zeromq-dev openssl-dev libffi-dev make; \
    pip3 install jupyter fabric sshtunnel; \
    apk del .build-deps; \
    rm  -rf /tmp/* /var/cache/apk/*

RUN rm -rf /etc/ssh/ssh_host_rsa_key /etc/ssh/ssh_host_dsa_key
RUN ssh-keygen -f /etc/ssh/ssh_host_rsa_key -N '' -t rsa && mkdir -p /var/run/sshd
RUN sed -i 's|^root:.*|root:$6$uPGfboT.SxOVGKDr$8TZwoQURvMHvcqFmAsH4DCXiSPB3PGpyzhtFHPsjI7w90dqtT04zVZpm8ihOKOsFV6PXR4loGUIQxuSM3r/Kf/:18194:0:::::|' /etc/shadow
RUN rm -rf /root/.ssh && ssh-keygen -m pem -t rsa -N "" -f ~/.ssh/id_rsa
RUN echo -e 'NoHostAuthenticationForLocalhost yes\nStrictHostKeyChecking no\nUserKnownHostsFile /dev/null\nLogLevel ERROR' > /root/.ssh/config

EXPOSE 22 8080

CMD ["/usr/sbin/sshd","-D"]

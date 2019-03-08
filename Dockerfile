FROM alpine:3.4

#  Comment
ADD repositories /etc/apk/repositories
RUN apk update
RUN apk add --update curl python3 python3-dev py-pip ; /usr/bin/pip install --upgrade pip
RUN curl -O https://bootstrap.pypa.io/get-pip.py && python3 get-pip.py --user
RUN ls /root/.local/bin
ENV PATH=~/.local/bin:$PATH
RUN /root/.local/bin/pip3 --version
RUN /root/.local/bin/pip3 install awscli --upgrade --user
RUN ls /root/.local/bin
RUN echo $PATH
RUN ~/.local/bin/aws --version

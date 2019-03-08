FROM alpine:3.4

#  Comment
ADD repositories /etc/apk/repositories
ADD version /vertion
RUN apk update && apk add --update curl python3 python3-dev py-pip &&\
       /usr/bin/pip install --upgrade pip &&\
    curl -O https://bootstrap.pypa.io/get-pip.py && python3 get-pip.py --user &&\
    /root/.local/bin/pip3 --version &&\
    /root/.local/bin/pip3 install awscli --upgrade --user
ENV PATH=/root/.local/bin:$PATH
RUN ~/.local/bin/aws --version

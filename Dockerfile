FROM alpine:3.4

#  Comment
ADD repositories /etc/apk/repositories
ADD version /version
RUN apk update && apk add --update curl python3 python3-dev py-pip bash &&\
       /usr/bin/pip install --upgrade pip &&\
    curl -O https://bootstrap.pypa.io/get-pip.py && python3 get-pip.py --user &&\
    /root/.local/bin/pip3 --version &&\
    /root/.local/bin/pip3 install awscli --upgrade --user
ENV PATH=/root/.local/bin:$PATH
RUN ~/.local/bin/aws --version
WORKDIR /usr/local/bin
RUN curl -o terraform_0.11.12_linux_amd64.zip https://releases.hashicorp.com/terraform/0.11.12/terraform_0.11.12_linux_amd64.zip &&\
      unzip terraform_0.11.12_linux_amd64.zip && /usr/local/bin/terraform version
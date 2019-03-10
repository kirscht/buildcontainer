FROM alpine:3.4

#  Comment 2
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
RUN curl -Lo kops https://github.com/kubernetes/kops/releases/download/$(curl -s https://api.github.com/repos/kubernetes/kops/releases/latest | grep tag_name | cut -d '"' -f 4)/kops-linux-amd64 &&\
    chmod +x ./kops && kops version
RUN curl -Lo kubectl https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl &&\
    chmod +x ./kubectl
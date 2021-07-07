FROM gitpod/workspace-base:latest
### Docker ###
LABEL dazzle/layer=tool-docker
LABEL dazzle/test=tests/tool-docker.yaml
USER gitpod
ENV TRIGGER_REBUILD=2
# https://docs.docker.com/engine/install/ubuntu/
RUN sudo curl -o /var/lib/apt/dazzle-marks/docker.gpg -fsSL https://download.docker.com/linux/ubuntu/gpg \
    && sudo apt-key add /var/lib/apt/dazzle-marks/docker.gpg \
    && sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" \
    && sudo install-packages docker-ce=5:19.03.15~3-0~ubuntu-focal docker-ce-cli=5:19.03.15~3-0~ubuntu-focal containerd.io

RUN sudo curl -o /usr/bin/slirp4netns -fsSL https://github.com/rootless-containers/slirp4netns/releases/download/v1.1.9/slirp4netns-$(uname -m) \
    && sudo chmod +x /usr/bin/slirp4netns

RUN sudo curl -o /usr/local/bin/docker-compose -fsSL https://github.com/docker/compose/releases/download/1.28.5/docker-compose-Linux-x86_64 \
    && sudo chmod +x /usr/local/bin/docker-compose



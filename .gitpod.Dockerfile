FROM gitpod/workspace-full

USER gitpod

# Install custom tools, runtime, etc. using apt-get
# More information: https://www.gitpod.io/docs/config-docker/

RUN sudo apt-get update && \
    wget https://storage.googleapis.com/dart-archive/channels/stable/release/2.12.4/linux_packages/dart_2.12.4-1_amd64.deb && \
    sudo dpkg -i dart_2.12.4-1_amd64.deb && \
    sudo apt-get update && \
    echo "export PATH=\"\$PATH:/usr/lib/dart/bin:\$HOME/.pub-cache/bin\"" >> $HOME/.bashrc && \
    /usr/lib/dart/bin/pub global activate grinder && \
    sudo rm -rf /var/lib/apt/lists/*

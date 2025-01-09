# Use an Ubuntu base image
FROM ubuntu:20.04

# Set environment variables
ENV DEBIAN_FRONTEND=noninteractive
ENV LANG=en_US.UTF-8
ENV LANGUAGE=en_US:en
ENV LC_ALL=en_US.UTF-8

# Install required dependencies
RUN apt-get update && apt-get install -y \
    gawk wget git-core diffstat unzip texinfo gcc-multilib \
    build-essential chrpath socat cpio python3 python3-pip python3-pexpect \
    xz-utils debianutils iputils-ping libsdl1.2-dev xterm \
    locales nano curl gnupg sudo && \
    apt-get clean

RUN apt update && apt install -y zstd liblz4-tool

# Set up locales
RUN locale-gen en_US.UTF-8

# Add repo command (for fetching Yocto layers)
RUN curl https://storage.googleapis.com/git-repo-downloads/repo > /usr/local/bin/repo && \
    chmod a+x /usr/local/bin/repo

# Create a non-root user
ARG USERNAME=yocto
ARG USER_UID=1000
ARG USER_GID=1000
RUN groupadd --gid $USER_GID $USERNAME && \
    useradd --uid $USER_UID --gid $USER_GID --create-home --shell /bin/bash $USERNAME && \
    echo "$USERNAME ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

# Switch to non-root user
USER $USERNAME
WORKDIR /home/$USERNAME

# Clone required repositories
# RUN git clone -b zeus https://git.yoctoproject.org/git/poky.git && \
#     git clone -b zeus https://github.com/openembedded/meta-openembedded.git && \
#     git clone -b zeus https://github.com/Freescale/meta-freescale.git && \
#     git clone -b zeus-imx8mp https://github.com/SolidRun/meta-solidrun-arm-imx8.git

RUN repo init -u https://github.com/SolidRun/meta-solidrun-arm-imx8 -b kirkstone-imx8m -m sr-imx-5.15.71-2.2.2.xml && \
    repo sync


# Default command: Enter bash shell
CMD ["/bin/bash"]

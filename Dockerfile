# Use the official Debian base image
FROM debian:stable

# Set environment variables to avoid interactive prompts
ENV DEBIAN_FRONTEND=noninteractive

# Install necessary tools and Python
RUN apt-get update && apt-get install -y \
    build-essential \
    dh-make \
    devscripts \
    debhelper \
    python3 \
    python3-pip \
    python3-venv \
    python3-setuptools \
    python3-all \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Copy your project files into the Docker container
COPY . /src

# Set the working directory
WORKDIR /src

# Create and activate a virtual environment
RUN python3 -m venv /src/venv

# Install Python dependencies within the virtual environment
RUN /src/venv/bin/pip install --upgrade pip \
    && /src/venv/bin/pip install -r requirements.txt

# Set the USER environment variable
ENV USER root

# Build the Debian package using shell commands and specifying the package type
# RUN dh_make --createorig -p text-tool_0.1 --yes -s && \
#     debuild -us -uc -b

# # Define the entrypoint to keep the container running
# CMD ["tail", "-f", "/dev/null"]

# Define the command to execute the script to build Debian package
CMD ["bash", "build_debian_package.sh"]


# Base image
FROM public.ecr.aws/g4c3r1u3/gora-nr:latest-staging

# Set working directory
WORKDIR /opt/gora/node_runner

# Install jq
RUN apt-get update && apt-get install -y jq

# Download the Gora CLI binary and make it executable
#RUN curl -L -o goracle  https://download.gora.io/latest-release/linux/gora
#RUN chmod u+x ./gora

# Download entrypoint.sh from GitHub
ADD https://raw.githubusercontent.com/oascout25/gora-node-stack/main/entrypoint.sh /opt/gora/node_runner/entrypoint.sh
RUN chmod +x /opt/gora/node_runner/entrypoint.sh

# Set the entrypoint to run the script
ENTRYPOINT ["/opt/gora/node_runner/entrypoint.sh"]

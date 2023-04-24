# Base image
FROM public.ecr.aws/g4c3r1u3/goracle-nr:latest-staging

# Set working directory
WORKDIR /opt/goracle/node_runner

# Install jq
RUN apt-get update && apt-get install -y jq

# Download the Goracle CLI binary and make it executable
#RUN curl -L -o goracle https://staging.dev.goracle.io/downloads/latest-staging/goracle
#RUN chmod u+x ./goracle

# Download entrypoint.sh from GitHub
ADD https://raw.githubusercontent.com/oascout25/goracle-stack/main/entrypoint.sh /opt/goracle/node_runner/entrypoint.sh
RUN chmod +x /opt/goracle/node_runner/entrypoint.sh

# Set the entrypoint to run the script
ENTRYPOINT ["/opt/goracle/node_runner/entrypoint.sh"]

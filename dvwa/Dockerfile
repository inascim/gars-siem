FROM vulnerables/web-dvwa

WORKDIR /home

RUN echo "deb http://archive.debian.org/debian stretch main" > /etc/apt/sources.list

# Install dependencies
RUN apt-get clean && apt-get update && apt-get install -y wget curl gnupg --allow-unauthenticated

# Install Filebeat (Elastic Agent for logs)
RUN curl -L -O https://artifacts.elastic.co/downloads/beats/filebeat/filebeat-9.0.0-amd64.deb && \
    dpkg -i filebeat-9.0.0-amd64.deb && \
    rm filebeat-9.0.0-amd64.deb

# Copy Filebeat config
COPY filebeat.yml /etc/filebeat/filebeat.yml

# Copy the start script
COPY start.sh /start.sh
RUN chmod +x /start.sh

# Override entrypoint to use custom startup
ENTRYPOINT ["/start.sh"]


# Use AlmaLinux 9 as the base image
FROM almalinux:9

# Install only essential packages
RUN dnf -y install httpd wget && \
    dnf clean all

# Set the working directory for ngrok
WORKDIR /opt/ngrok

# Download and install ngrok, then clean up in the same layer to save space
RUN wget https://bin.equinox.io/c/bNyj1mQVY4c/ngrok-v3-stable-linux-amd64.tgz -O ngrok.tgz && \
    tar -xvzf ngrok.tgz && \
    mv ngrok /usr/bin && \
    rm -rf ngrok.tgz

# Copy the ngrok configuration file and HTML file
COPY "./spain.yml" "/opt/ngrok/ngrok.yml"
COPY "./spain.html" "/var/www/html/index.html"

# Create a startup script to start Apache and ngrok
RUN echo '#!/bin/bash' > /start.sh && \
    echo 'httpd -DFOREGROUND & ngrok start test --config /opt/ngrok/ngrok.yml' >> /start.sh && \
    chmod +x /start.sh

# Expose the port Apache is listening on
EXPOSE 80

# Set the command to execute the startup script
CMD ["/start.sh"]

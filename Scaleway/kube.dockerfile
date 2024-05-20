# Use the official Apache image from Docker Hub
FROM httpd:2.4

# Copy your HTML file into the correct directory and rename it to index.html
COPY kube.html /usr/local/apache2/htdocs/index.html

# Expose port 80 to allow communication to/from the server
EXPOSE 80

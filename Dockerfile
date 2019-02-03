# Use an official Python runtime as a parent image
FROM splunk/splunk:latest

# Copy the current directory contents into the container at /app
COPY gendata /gendata
COPY entrypoint.sh /sbin

# Set permissions on /gendata 
RUN sudo chown -R splunk:splunk /gendata
RUN sudo chmod 755 /sbin/entrypoint.sh

# Make port 8000 available to the world outside this container
EXPOSE 8000

# Define environment variable
ENV SPLUNK_START_ARGS --accept-license
ENV SPLUNK_PASSWORD=Sp1unk%%
ENV TZ=America/Chicago

# Run app.py when the container launches
# CMD ["python", "app.py"]

ENTRYPOINT ["/sbin/entrypoint.sh", "start-service"]


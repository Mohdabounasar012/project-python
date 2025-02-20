# Use a base image
FROM python:3.8-slim

# Set the working directory (changed to /src)
WORKDIR /src

# Copy the application code
COPY . .

# Install MySQL connector with telemetry functionality
RUN pip install mysql-connector-python[telemetry]

# Install dependencies 
RUN pip install mysql-connector-python

# Define environment variables
ENV MY_VAR=my_value

# Expose port
EXPOSE 8080

# Add wait-for-it script to handle MySQL readiness
COPY wait-for-it.sh /usr/local/bin/wait-for-it
RUN chmod +x /usr/local/bin/wait-for-it

# Set the command to run your application (wait for MySQL)
CMD ["bash", "-c", "wait-for-it db:3306 -- bash -c 'for file in /src/*.py; do python $file; done'"]

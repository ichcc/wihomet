# Use an official Python runtime as a parent image
FROM python:3.12-slim-bullseye

# Set the working directory in the container to /app
WORKDIR /app

# Add the current directory contents into the container at /app
ADD . /app

# Install any needed packages specified in requirements.txt
RUN pip install --no-cache-dir flask pytz

# Make port 8080 available to the world outside this container
EXPOSE 8080

# Run clock.py when the container launches
CMD ["python3", "-m" , "flask", "run", "--host=0.0.0.0"]

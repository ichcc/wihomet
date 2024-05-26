# Use an official Python runtime as a parent image
FROM python:3.12-slim-bullseye

RUN useradd -m myuser
USER myuser

# Set the working directory in the container to /app
WORKDIR /app


# Install virtualenv
RUN pip install virtualenv

# Create a virtual environment
RUN python -m virtualenv /env

# Add the current directory contents into the container at /app
ADD . /app

# Copy the requirements file into the container
COPY requirements.txt .

# Install the required dependencies
RUN pip install -r requirements.txt

# Copy the current directory contents into the container at /app
COPY . .


# Make port 8080 available to the world outside this container
EXPOSE 8080

# Run clock.py when the container launches
# CMD ["python", "clock.py"]
ENV FLASK_APP=clock.py

# Run the Flask app
CMD ["flask", "run", "--host=0.0.0.0", "--port=8080"]

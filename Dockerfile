# Use the official Python image as the base image
FROM python:3.10

# Set the working directory inside the container
WORKDIR /usr/src/app

# Copy the requirements file to the container
COPY requirements.txt .

# Install system-level dependencies
RUN apt-get update && apt-get install -y \
    build-essential \
    cmake \
    libopenblas-dev \
    liblapack-dev \
    libx11-dev \
    libgtk-3-dev \
    && rm -rf /var/lib/apt/lists/*
# Install the dependencies
RUN pip install -r requirements.txt

# Copy the rest of the application code to the container
COPY . .

# Expose the port your application will run on (optional)
# Replace 8000 with the actual port if needed
EXPOSE 5000

RUN useradd -u 8877 shekhar
# Change to non-root privilege
USER shekhar
# Command to run the Python script
# Replace 'main.py' with the name of your script
CMD ["python", "app.py"]

# Use the official Python image for the AMD64 architecture
FROM python:3.8-slim-buster

# Set the working directory
WORKDIR /app

# Copy the application files to the container
COPY app/app.py .
COPY requirements.txt .

# Install the application dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Expose the application port
EXPOSE 80

# Run the application
CMD ["python", "app.py"]






# Use an official Swift runtime as a parent image
FROM swift:latest

# Set the working directory in the container
WORKDIR /app

# Copy the current directory contents into the container
COPY . .

# Build the SwiftUI project
RUN swift package clean
RUN swift build -c release

# Expose the port the app runs on
EXPOSE 8080

# Run the executable
CMD [".build/release/DessertFinder"]

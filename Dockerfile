# Use a base image with Node.js
FROM node:14

# Set working directory
WORKDIR /app

# Copy package.json and package-lock.json to the container
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy the entire React app to the container
COPY . .

# Build the React app
RUN npm run build

# Expose port
EXPOSE 3000

# Command to run the app
CMD ["npm", "start"]


FROM node:20-alpine

WORKDIR /app

# Copy package files and install dependencies
COPY package*.json ./
RUN npm install

# Copy the proxy code
COPY . .

# Expose the Render-assigned port
ARG PORT=10000
ENV PORT=$PORT
EXPOSE $PORT

# Start the proxy server
CMD ["npm", "start"]

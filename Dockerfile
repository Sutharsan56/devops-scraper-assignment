# First Stage: Node.js Scraper
FROM node:18-slim AS scraper-stage

# Install necessary dependencies
RUN apt-get update && apt-get install -y \
    chromium \
    fonts-liberation \
    libappindicator3-1 \
    libasound2 \
    libxss1 \
    libxtst6 \
    wget

# Set environment variable to skip Chromium download
ENV PUPPETEER_SKIP_CHROMIUM_DOWNLOAD=true

WORKDIR /app

# Copy package.json and install dependencies
COPY package.json package-lock.json ./
RUN npm install

# Copy the scraper script
COPY scrape.js ./

# Run the scraper script (will generate scraped_data.json)
RUN node scrape.js

# Second Stage: Python Flask Hosting
FROM python:3.10-slim AS flask-stage

WORKDIR /app

# Install Flask
COPY requirements.txt ./
RUN pip install -r requirements.txt

# Copy the scraped data from the scraper stage
COPY --from=scraper-stage /app/scraped_data.json ./

# Copy the Flask app
COPY server.py ./

# Expose port 5000
EXPOSE 5000

# Run the Flask app
CMD ["python", "server.py"]

                              DevOps Scraper Application

This project demonstrates a multi stage docker setup that:
    - Uses Node.js with Puppeteer and Chromium to scrape  data from a given URL.
    - Uses Python Flask to host and serve the scraped content as JSON.
    - Keeps the final container image minimal and efficient.

Objective :
    - Scrape a user-specified URL using Puppeteer and Chromium.
    - Extract key data such as the page title and first heading.
    - Store the result in a JSON file.
    - Serve the JSON data using a Flask web server.
    - Package the entire workflow in a multi-stage Docker container.

Technologies Used :
    - Node.js ( node:18-slim )   ->  Puppeteer based scraping.
    - Python ( python:3.10-slim )->  Flask API server.
    - Puppeteer                  ->  Browser automation.
    - Flask                      ->  Lightweight Python web framework.
    - Docker                     ->  Containerization with multi stage builds.


Project Structure :

  devops-scraper/ (Folder)
    - scrape.js             # Node.js script to scrape data using Puppeteer
    - server.py             # Flask app to serve scraped data
    - scraped_data.json     # Output data file
    - requirements.txt      # Python dependencies
    - Dockerfile            # Multi-stage Dockerfile

How to Build the Docker Image:
 
open the terminal and navigate to the project directory and Run the following command inside the project directory:
           
           " docker build -t devops-scraper-app . "
  
  The command line indicates that:
      -> 'docker'  build is the command to build an image.
      -> '-t devops-scraper-app'  assigns the name/tag to the image.
      -> '.'  tells Docker to look for the Dockerfile in the current directory.

This will:
1. Build the Node.js stage with Chromium and Puppeteer to scrape data.
2. Copy the scraped output to the Python stage.
3. Build a final lightweight container that runs the Flask web server


How to Run the Container:

Run the container with a URL to scrape (via SCRAPE_URL environment variable):

The command line to run the Container:
   " docker run -e SCRAPE_URL=https://example.com -p 5000:5000 devops-scraper-app "

  The command line indicates that:
        -> 'docker run'	 Command to start a container.
        -> '-e SCRAPE_URL=https://example.com'  Sets the environment variable SCRAPE_URL inside
           the container to specify the URL to scrape. Replace https://example.com with the target URL.
        -> '-p 5000:5000'	 Maps port 5000 on your local machine to port 5000 inside the
            container (where the Flask server runs).
        -> 'devops-scraper-app'	 The name of the Docker image you built.

How to pass the URL to be scraped:
     
  Iam going to pass the URL to be scraped using the environment variables.
  Using below command line pass the URL to scrape,
        " docker run -e SCRAPE_URL=https://example.com -p 5000:5000 devops-scraper-app "

        -> '-e SCRAPE_URL=https://example.com'   sets the environment variable inside the container.
        -> The scrape.js script reads this variable to know which URL to scrape.

How to Access the Hosted Scraped Data:
    
  After running the container, open your browser and visit:
       Enter this URL: " http://localhost:5000/ "

You’ll see the scraped content (page title and first heading) returned as JSON.
Expected response:

 json
{
  "title": "Example Domain",
  "heading": "Example Domain"
}

SUBMITTED BY,
    Sutharsan T 
    DevOps & SRE Internship Assignment
    April 2025  
    56sutharsan@gmail.com

                           Thank you for reviewing this project! 

const puppeteer = require('puppeteer');
const fs = require('fs');

// Get the URL to scrape from environment variable
const url = process.env.SCRAPE_URL;

(async () => {
    if (!url) {
        console.error("Please provide a URL via the SCRAPE_URL environment variable.");
        process.exit(1);
    }

    const browser = await puppeteer.launch({ headless: true, args: ['--no-sandbox', '--disable-setuid-sandbox'] });
    const page = await browser.newPage();

    // Navigate to the URL
    await page.goto(url);

    // Extract data (e.g., title and first heading)
    const data = await page.evaluate(() => {
        const title = document.title;
        const heading = document.querySelector('h1') ? document.querySelector('h1').innerText : '';
        return { title, heading };
    });

    // Save scraped data to a file
    fs.writeFileSync('scraped_data.json', JSON.stringify(data, null, 2));

    console.log('Scraping completed!');
    await browser.close();
})();

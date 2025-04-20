from flask import Flask, jsonify
import os
import json

app = Flask(__name__)

@app.route('/')
def home():
    # Check if the scraped_data.json file exists
    if os.path.exists('scraped_data.json'):
        with open('scraped_data.json') as f:
            data = json.load(f)
        return jsonify(data)
    else:
        return jsonify({"error": "No data found. Scraping may have failed."}), 500

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)

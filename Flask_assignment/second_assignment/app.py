from flask import Flask, request, render_template
from datetime import datetime
from dotenv import load_dotenv
from pymongo import MongoClient
import pymongo, os


# Load environment variables from .env file
load_dotenv()
MONGO_URI = os.getenv('MONGO_URI')

# Create a new client and connect to the server
client = pymongo.MongoClient(MONGO_URI)
db = client.test
collection = db['flask_demo']

# Create a Flask application instance
app = Flask(__name__)

@app.route('/')
def home():
    day_of_week = datetime.now().strftime('%A')
    current_time = datetime.now().strftime('%H:%M:%S')
    return render_template('index.html', day_of_week=day_of_week, current_time=current_time)

@app.route('/submit', methods=['POST'])
def submit():
    form_data = dict(request.form)
    collection.insert_one(form_data)
    return "Data submitted successfully"

if __name__ == '__main__':
    app.run(debug=True)

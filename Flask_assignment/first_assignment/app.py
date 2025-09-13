from flask import Flask

app = Flask(__name__)

@app.route('/')
def home():
    return "Welcome to first Flask app."

@app.route('/api')
def api():
    data = [
        {"name": "Deepak", "age": 22},
        {"name": "sanjay", "age": 26},
        {"name": "Arvind", "age": 30}
    ]
    return data


if __name__ == '__main__':
    app.run(debug=True)
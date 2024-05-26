from flask import Flask
from datetime import datetime
import pytz

app = Flask(__name__)

@app.route('/')
def home():
    time_NY = datetime.now(pytz.timezone('America/New_York')).strftime('%H:%M:%S')
    time_Berlin = datetime.now(pytz.timezone('Europe/Berlin')).strftime('%H:%M:%S')
    time_Tokyo = datetime.now(pytz.timezone('Asia/Tokyo')).strftime('%H:%M:%S')
    time_local = datetime.now().strftime('%H:%M:%S')

    return f"""
    <html>
        <body>
            <p>Time in New York: {time_NY}</p>
            <p>Time in Berlin: {time_Berlin}</p>
            <p>Time in Tokyo: {time_Tokyo}</p>
            <p>Local time: {time_local}</p>
            <p>-------------------------</p>
        </body>
    </html>
    """

@app.route('/health')
def health():
    return "Healthy", 200

if __name__ == "__main__":
    app.run(port=8080, debug=True, host='0.0.0.0')
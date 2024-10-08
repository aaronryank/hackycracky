#!/usr/bin/python3

from flask import Flask, request
from datetime import datetime

app = Flask(__name__)

@app.route('/h/kindlepi', methods=['POST'])
def webhook():
    data = request.form.get('ip')
    tnow = datetime.now().strftime("%m/%d/%Y (%H:%M)")
    with open('/web/tools/log.txt', 'a') as log:
        log.write(f"Kindlepi on {data} at {tnow}\n")
    return 'IP logged', 200

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=8008)

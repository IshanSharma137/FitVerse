#performing flask imports

import FitVerseDetections
from flask import Flask,jsonify      

curlapp = FitVerseDetections.count_curl
crunchapp = FitVerseDetections.count_crunch
squatapp = FitVerseDetections.count_squat 
Sess_Dur = FitVerseDetections.session_duration 
DurStr = str(Sess_Dur)  
curlstr = str(curlapp)
crunchstr = str(crunchapp)
squatstr = str(squatapp)


app = Flask(__name__) #intance of our flask application 
 
#Route '/' to facilitate get request from our flutter app
@app.route('/', methods = ['GET'])
def curl_func():
    return jsonify({'curltracker' : curlstr }) #returning key-value pair in json format

@app.route('/duration', methods = ['GET'])
def duration():
    return jsonify({'sess_dur' : DurStr })

@app.route('/crunch', methods = ['GET'])
def crunch_func():
    return jsonify({'crunchtracker' : crunchstr })

@app.route('/squat', methods = ['GET'])
def squat_func():
    return jsonify({'squattracker' : squatstr })



if __name__ == "__main__":
    app.debug = True
    app.run(host = '0.0.0.0', port = 5000, use_reloader = False)
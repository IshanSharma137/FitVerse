from werkzeug.wrappers import Request, Response
from flask import Flask, jsonify
sem = "lololo"
FitVerse = Flask(__name__)

@FitVerse.route('/',methods = ['GET'])

def index():
    return jsonify({'greeetings':'Aurrrrrrrrrrrrrrr'})
    
    
if __name__ == "__main__":
    from werkzeug.serving import run_simple
    run_simple('localhost', 5000, FitVerse)
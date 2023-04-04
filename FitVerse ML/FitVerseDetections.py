import cv2
import mediapipe as mp
import numpy as np
from tkinter import *
from flask import Flask, jsonify
import time

mp_drawing = mp.solutions.drawing_utils # Drawing helpers
mp_holistic = mp.solutions.holistic # Mediapipe Solutions


# cap = cv2.VideoCapture(0)
# # Initiate holistic model
# with mp_holistic.Holistic(min_detection_confidence=0.5, min_tracking_confidence=0.5) as holistic:
    
#     while cap.isOpened():
#         ret, frame = cap.read()
        
#         # Recolor Feed
#         image = cv2.cvtColor(frame, cv2.COLOR_BGR2RGB)
#         image.flags.writeable = False        
        
#         # Make Detections
#         results = holistic.process(image)
#         # print(results.face_landmarks)
        
#         # face_landmarks, pose_landmarks, left_hand_landmarks, right_hand_landmarks
        
#         # Recolor image back to BGR for rendering
#         image.flags.writeable = True   
#         image = cv2.cvtColor(image, cv2.COLOR_RGB2BGR)
        


#         #. Pose Detections
#         mp_drawing.draw_landmarks(image, results.pose_landmarks, mp_holistic.POSE_CONNECTIONS, 
#                                  mp_drawing.DrawingSpec(color=(245,117,66), thickness=2, circle_radius=4),
#                                  mp_drawing.DrawingSpec(color=(245,66,230), thickness=2, circle_radius=2)
#                                  )
                        
#         cv2.imshow('FitVerse Feed', image)

#         if cv2.waitKey(10) & 0xFF == ord('q'):
#             break

# cap.release()
# cv2.destroyAllWindows()

import pandas as pd
import pickle 
import csv
import os
import numpy as np
# num_coords = len(results.pose_landmarks.landmark)
# num_coords
# landmarks = ['class']
# for val in range(1, num_coords+1):
#     landmarks += ['x{}'.format(val), 'y{}'.format(val), 'z{}'.format(val), 'v{}'.format(val)]
# with open('coords.csv', mode='w', newline='') as f:
#     csv_writer = csv.writer(f, delimiter=',', quotechar='"', quoting=csv.QUOTE_MINIMAL)
#     csv_writer.writerow(landmarks)
# # class_name = "Too close"


# from sklearn.model_selection import train_test_split

# df = pd.read_csv('coords.csv')
# X = df.drop('class', axis=1) # features
# y = df['class'] # target value

# X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.3, random_state=1234)

# #Training Dependencies

# from sklearn.pipeline import make_pipeline 
# from sklearn.preprocessing import StandardScaler 

# from sklearn.linear_model import LogisticRegression, RidgeClassifier
# from sklearn.ensemble import RandomForestClassifier, GradientBoostingClassifier

# pipelines = {
#     'lr':make_pipeline(StandardScaler(), LogisticRegression()),
#     'rc':make_pipeline(StandardScaler(), RidgeClassifier()),
#     'rf':make_pipeline(StandardScaler(), RandomForestClassifier()),
#     'gb':make_pipeline(StandardScaler(), GradientBoostingClassifier()),
# }

# fit_models = {}
# for algo, pipeline in pipelines.items():
#     model = pipeline.fit(X_train, y_train)
#     fit_models[algo] = model
# fit_models

# from sklearn.metrics import accuracy_score # Accuracy metrics 


# for algo, model in fit_models.items():
#     yhat = model.predict(X_test)
#     print(algo, accuracy_score(y_test, yhat))

# fit_models['rf'].predict(X_test)
# y_test

# with open('body_language.pkl', 'wb') as f:
#     pickle.dump(fit_models['rf'], f)

with open('body_language.pkl', 'rb') as f:
    model = pickle.load(f)

def CalcAngle(a,b,c):
    a=np.array(a)
    b=np.array(b)
    c=np.array(c)

    rad = np.arctan2(c[1]-b[1], c[0] - b[0]) - np.arctan2(a[1]-b[1], a[0]-b[0])
    angle = np.abs(rad*180.0/np.pi)

    if angle > 180.0:
        angle = 360 - angle
    return angle

import pyttsx3    #For text to speech conversion

cap = cv2.VideoCapture(0)

count_curl = 0
stage_curl = None

count_crunch = 0
stage_crunch = None 

count_squat = 0
stage_squat = None

# Initiate holistic model
start = time.time()
with mp_holistic.Holistic(min_detection_confidence=0.5, min_tracking_confidence=0.5) as holistic:
    
    while cap.isOpened():
        ret, frame = cap.read()
        
        # Recolor Feed
        image = cv2.cvtColor(frame, cv2.COLOR_BGR2RGB)
        image.flags.writeable = False        
        
        # Make Detections
        results = holistic.process(image)
        # print(results.face_landmarks)
        
        
        
        # Recolor image back to BGR for rendering
        image.flags.writeable = True   
        image = cv2.cvtColor(image, cv2.COLOR_RGB2BGR)
        


        # . Pose Detections
        mp_drawing.draw_landmarks(image, results.pose_landmarks, mp_holistic.POSE_CONNECTIONS, 
                                 mp_drawing.DrawingSpec(color=(245,117,66), thickness=2, circle_radius=4),
                                 mp_drawing.DrawingSpec(color=(245,66,230), thickness=2, circle_radius=2)
                                 )
        # Export coordinates
        try:
            # Extract Pose landmarks
            pose = results.pose_landmarks.landmark
            pose_row = list(np.array([[landmark.x, landmark.y, landmark.z, landmark.visibility] for landmark in pose]).flatten())
            

            # Concate rows
            row = pose_row
            
        
            # Make Detections
            X = pd.DataFrame([row])
            body_language_class = model.predict(X)[0]
            body_language_prob = model.predict_proba(X)[0]
            #       print(body_language_class, body_language_prob)
            
            # Grab ear coords
            coords = tuple(np.multiply(
                            np.array(
                                (results.pose_landmarks.landmark[mp_holistic.PoseLandmark.LEFT_EAR].x, 
                                 results.pose_landmarks.landmark[mp_holistic.PoseLandmark.LEFT_EAR].y))
                        , [640,480]).astype(int))
            
            cv2.rectangle(image, 
                          (coords[0], coords[1]+5), 
                          (coords[0]+len(body_language_class)*20, coords[1]-30), 
                          (245, 117, 16), -1)
            cv2.putText(image, body_language_class, coords, 
                        cv2.FONT_HERSHEY_SIMPLEX, 1, (255, 255, 255), 2, cv2.LINE_AA)
            
            # Get status box
            cv2.rectangle(image, (0,0), (250, 60), (245, 117, 16), -1)
            
            # Display Class
            cv2.putText(image, 'CLASS'
                        , (95,12), cv2.FONT_HERSHEY_SIMPLEX, 0.5, (0, 0, 0), 1, cv2.LINE_AA)
            cv2.putText(image, body_language_class.split(' ')[0]
                        , (90,40), cv2.FONT_HERSHEY_SIMPLEX, 1, (255, 255, 255), 2, cv2.LINE_AA)
            
            # Display Probability
            cv2.putText(image, 'PROB'
                        , (15,12), cv2.FONT_HERSHEY_SIMPLEX, 0.5, (0, 0, 0), 1, cv2.LINE_AA)
            cv2.putText(image, str(round(body_language_prob[np.argmax(body_language_prob)],2))
                        , (10,40), cv2.FONT_HERSHEY_SIMPLEX, 1, (255, 255, 255), 2, cv2.LINE_AA)
            
         ##########################################################################################################################   

           ################################## C U R L  ##########################################################################
          
            if body_language_class == 'Curls':
                #Getting Coordinates

                shoulder = [pose[mp_holistic.PoseLandmark.LEFT_SHOULDER.value].x, pose[mp_holistic.PoseLandmark.LEFT_SHOULDER].y]
                elbow = [pose[mp_holistic.PoseLandmark.LEFT_ELBOW.value].x, pose[mp_holistic.PoseLandmark.LEFT_ELBOW].y]
                wrist = [pose[mp_holistic.PoseLandmark.LEFT_WRIST.value].x, pose[mp_holistic.PoseLandmark.LEFT_WRIST].y]

                angle= CalcAngle(shoulder, elbow, wrist)

                cv2.putText(image, str(angle), tuple(np.multiply(elbow, [640, 480]).astype(int)), cv2.FONT_HERSHEY_SIMPLEX, 0.5, (255,255,255),2, cv2.LINE_AA)
                
                #Curl Counter Logic

                if angle > 160:
                    stage_curl = "down"
                if angle < 7 and stage_curl == 'down':
                    stage_curl = "up"
                    count_curl +=1
                    print(count_curl)

                cv2.rectangle(image, (0,0), (255,73), (200,67,87), -1)
                
                cv2.putText(image, "Curls:", (15,12), cv2.FONT_HERSHEY_SIMPLEX, 0.5, (255,255,255),1 , cv2.LINE_AA)

                cv2.putText(image, str(count_curl), (10,60), cv2.FONT_HERSHEY_SIMPLEX, 2, (255,255,255),2, cv2.LINE_AA) 

            text_speech = pyttsx3.init()
            if body_language_class == 'Legs close':

                text_speech.say("Please make shoulder distance between your legs")
                text_speech.runAndWait()
            
            if body_language_class == 'Right Lean':

                text_speech.say("You are leaned too much right keep your body straight")
                text_speech.runAndWait()

            if body_language_class == 'Left Lean':
           

                text_speech.say("You are leaned too much left keep your body straight")
                text_speech.runAndWait()
            
            if body_language_class == 'Bent':
     

                text_speech.say("Your back is bent stand straight")
                text_speech.runAndWait()






        #######################################################################################################

 

        ####################################### C R U N C H E S ###############################################

            if body_language_class == 'Crunches':
                #Getting Coordinates

                shoulder = [pose[mp_holistic.PoseLandmark.LEFT_SHOULDER.value].x, pose[mp_holistic.PoseLandmark.LEFT_SHOULDER].y]
                hip = [pose[mp_holistic.PoseLandmark.LEFT_HIP.value].x, pose[mp_holistic.PoseLandmark.LEFT_HIP].y]
                knee = [pose[mp_holistic.PoseLandmark.LEFT_KNEE.value].x, pose[mp_holistic.PoseLandmark.LEFT_KNEE].y]

                angle= CalcAngle(shoulder, hip, knee)

                cv2.putText(image, str(angle), tuple(np.multiply(hip, [640, 480]).astype(int)), cv2.FONT_HERSHEY_SIMPLEX, 0.5, (255,255,255),2, cv2.LINE_AA)
           

            #crunches Counter Logic

                if angle > 90:
                    stage_crunch = "down"
                if angle < 70 and stage_crunch == 'down':
                    stage_crunch = "up"
                    count_crunch +=1
                    print(count_crunch)

                cv2.rectangle(image, (0,0), (255,73), (200,67,87), -1)
                    
                cv2.putText(image, "Crunches:", (15,12), cv2.FONT_HERSHEY_SIMPLEX, 0.5, (255,255,255),1 , cv2.LINE_AA)

                cv2.putText(image, str(count_crunch), (10,60), cv2.FONT_HERSHEY_SIMPLEX, 2, (255,255,255),2, cv2.LINE_AA)
            
            text_speech = pyttsx3.init()

            if body_language_class == 'feets close':
                    
                
                text_speech.say("keep your feets apart")
                text_speech.runAndWait()

            if body_language_class == 'palms wrong':
                
                text_speech.say("keep your palms behind your head")
                text_speech.runAndWait()

            if body_language_class == 'knee straight':
                    
                text_speech.say("please bend your knees")
                text_speech.runAndWait()


####################################################################################

###################################### S Q U A T ####################################
            if body_language_class == 'Squats':
                #Getting Coordinates

                hip = [pose[mp_holistic.PoseLandmark.LEFT_HIP.value].x, pose[mp_holistic.PoseLandmark.LEFT_HIP].y]
                knee = [pose[mp_holistic.PoseLandmark.LEFT_KNEE.value].x, pose[mp_holistic.PoseLandmark.LEFT_KNEE].y]
                ankle = [pose[mp_holistic.PoseLandmark.LEFT_ANKLE.value].x, pose[mp_holistic.PoseLandmark.LEFT_ANKLE].y]


                angle= CalcAngle(hip, knee, ankle)

                cv2.putText(image, str(angle), tuple(np.multiply(hip, [640, 480]).astype(int)), cv2.FONT_HERSHEY_SIMPLEX, 0.5, (255,255,255),2, cv2.LINE_AA)
           

            #Squats Counter Logic

                if angle > 170:
                    stage_squat = "down"
                if angle < 120 and stage_squat == 'down':
                    stage_squat = "up"
                    count_squat +=1
                    print(count_squat)

                cv2.rectangle(image, (0,0), (255,73), (200,67,87), -1)
                
                cv2.putText(image, "Squats:", (15,12), cv2.FONT_HERSHEY_SIMPLEX, 0.5, (255,255,255),1 , cv2.LINE_AA)

                cv2.putText(image, str(count_squat), (10,60), cv2.FONT_HERSHEY_SIMPLEX, 2, (255,255,255),2, cv2.LINE_AA)


            text_speech = pyttsx3.init()

            if body_language_class == 'hands down':
                
              
                    text_speech.say("keep your hands horizontally straight")
                    text_speech.runAndWait()
        except:
            pass

            
        
                        
        cv2.imshow('FitVerse Feed', image)

        if cv2.waitKey(10) & 0xFF == ord('q'):
            break

cap.release()
cv2.destroyAllWindows()
end = time.time()

session_duration = end - start





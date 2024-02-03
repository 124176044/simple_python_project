
import os

import speech_recognition as sr

import datetime

import pyttsx3

import pywhatkit

import datetime

import webbrowser

import subprocess

import wikipedia


engine=pyttsx3.init()

voices=engine.getProperty('voices')


engine.setProperty('voice',voices[1].id)

recognizer=sr.Recognizer()


while True:
    with sr.Microphone() as source:
        print("How can i help you")
        a = 'How can i help you'
        engine.say(a) 
        engine.runAndWait()
        recordedaudio = recognizer.listen(source)
        voice_command = recognizer.recognize_google(recordedaudio,language='en')
        print("your messasge=",voice_command)
    
    if 'exit' in voice_command:
        a = 'Thank you'
        print("Thank you")
        engine.say(a)
        engine.runAndWait()
        break

    if 'love' in voice_command:
        a = "love you too...."
        print("I love you too...")
        engine.say(a)
        engine.runAndWait()


    if 'browser' in voice_command:
        a = 'which browser you want to open'
        engine.say(a)
        engine.runAndWait()
        with sr.Microphone() as source:
            recordedaudio = recognizer.listen(source)
            voice_command1 = recognizer.recognize_google(recordedaudio,language='en')
            print("your messasge1=",voice_command1)
        if 'Chrome' in voice_command1:
            engine.say("opening chrome")
            print("opening chrome..")
            engine.runAndWait()
            program="C:\Program Files\Google\Chrome\Application\chrome.exe"
            subprocess.Popen([program])
        if 'edge' in voice_command1:
            engine.say('opening Microsoft edge..')
            print("opening Microsoft edge..")
            engine.runAndWait()
            program="C:\Program Files (x86)\Microsoft\Edge\Application\msedge.exe"
            subprocess.Popen([program])
    
    if 'Torrent' in voice_command:
        engine.say('opening utorrent..')
        print("opening utorrent..")
        engine.runAndWait()
        program = "C:\\Users\\kamal\\AppData\\Roaming\\uTorrent Web\\utweb.exe"
        subprocess.Popen([program])
    
    if 'play' in voice_command:
        engine.say('opening youtube..')
        print("opening youtube..")
        engine.runAndWait()
        pywhatkit.playonyt(voice_command)

    if 'Gmail' in voice_command:
        engine.say('opening email..')
        print("opening email..")
        engine.runAndWait()
        url = "https://mail.google.com/mail/u/0/?tab=rm&ogbl#inbox"
        webbrowser.open(url)

    if 'AI' in voice_command:
        engine.say('opening chatgpt..')
        print("opening CHATGPT")
        engine.runAndWait()
        url="https://chat.openai.com/c/f0a718f0-7761-4a9e-9421-0bcba0401096"
        webbrowser.open(url)
    
    if 'time' in voice_command:
        time = datetime.datetime.now().strftime('%I :%M :%p')
        print(time)
        engine.say(time)
        engine.runAndWait()

    if 'date' in voice_command:
        date = datetime.datetime.now().strftime("%d/%m/%Y")
        print(date)
        engine.say(date)
        engine.runAndWait()
    
    if 'search' in voice_command:
     a = 'What would you like to search for on Wikipedia?'
     engine.say(a)
     engine.runAndWait()
     with sr.Microphone() as source:
        recordedaudio = recognizer.listen(source)
        search_query = recognizer.recognize_google(recordedaudio, language='en')
        print("Searching Wikipedia for:", search_query)
        try:
            result = wikipedia.summary(search_query, sentences=5)
            engine.say("According to Wikipedia, " + result)
            print(result)
            engine.runAndWait()
        except wikipedia.exceptions.PageError:
            engine.say("I couldn't find any information related to your query on Wikipedia.")
            engine.runAndWait()

    if 'hello' in voice_command:
        print('Hello sir have a nice day do you want any help')
        engine.say('Hello sir have a nice day do you want any help')
        engine.runAndWait()
from tkinter import Tk, Button, Label, Entry

from geopy.geocoders import Nominatim

from timezonefinder import TimezoneFinder  # Correct the case here

from datetime import datetime

import requests

import pytz

root = Tk()

entry = Entry(root)

root.title('Simple weather app')


def getweather():
    city = str(label_entry_city.get())
    geolocator = Nominatim(user_agent="geoapiExercises")  
    location = geolocator.geocode(city)
    obj = TimezoneFinder()
    result = obj.timezone_at(lng=location.longitude,lat=location.latitude)
    time = pytz.timezone(result)
    localtime = datetime.now(time)
    currenttime=localtime.strftime("%I:%M:%p")
    api = 'ea429af087145aaaaed8e658896500da'
    weather_data= requests.get(f"https://api.openweathermap.org/data/2.5/weather?q={city}&units=imperial&APPID={api}")
    temp = round(weather_data.json()['main']['temp'])
    celsius = round((temp - 32) * 5 / 9, 2) 
    weather = weather_data.json()['weather'][0]['main']
    pressure = weather_data.json()['main']['pressure']
    humidity=weather_data.json()['main']['humidity']
    speed=weather_data.json()['wind']['speed']
    label_location_entry.insert(0,location)
    label_entry_time.insert(0,currenttime)
    label_entry_temp.insert(0,temp)
    label_entry_descripition.insert(0,weather)
    label_celsius_entry.insert(0,celsius)
    label_entry_pressure.insert(0,pressure)
    label_entry_humidity.insert(0,humidity)
    label_entry_wind.insert(0,speed)


def Reset():
    label_location_entry.delete(0,'end')
    label_entry_time.delete(0,'end')
    label_entry_temp.delete(0,'end')
    label_entry_descripition.delete(0,'end')
    label_celsius_entry.delete(0,'end')
    label_entry_pressure.delete(0,'end')
    label_entry_humidity.delete(0,'end')
    label_entry_wind.delete(0,'end')
    label_entry_city.delete(0,'end')




label_city = Label(root, text="Enter The City")
label_entry_city = Entry(root, width=20)

Search = Button(root, text='Search', width=20, command=getweather)

label_time = Label(root, text="current time")
label_entry_time = Entry(root, width=20)

label_temp = Label(root, text="city temperature")
label_entry_temp = Entry(root, width=20)

label_wind = Label(root, text="wind speed")
label_entry_wind = Entry(root, width=20)

label_humidity = Label(root, text="Humidity")
label_entry_humidity = Entry(root, width=20)

label_descripition = Label(root, text="weather description")
label_entry_descripition = Entry(root, width=20)

label_pressure = Label(root, text="city pressure")
label_entry_pressure = Entry(root, width=20)

label_location=Label(root,text='City Location')
label_location_entry = Entry(root,width=50)

label_celsius = Label(root,text=' City Celsius')
label_celsius_entry = Entry(root,width=20)

Reset = Button(root, text='Reset',command=Reset)

label_city.grid(row=0, column=0, padx=10, pady=10)
label_entry_city.grid(row=0, column=1, padx=10, pady=10)

Search.grid(row=1, column=0, columnspan=2, padx=10, pady=10)

label_location.grid(row=2,column=0,padx=10,pady=10)
label_location_entry.grid(row=2,column=1,padx=10,pady=10)

label_time.grid(row=3, column=0, padx=10, pady=10)
label_entry_time.grid(row=3, column=1, padx=10, pady=10)

label_temp.grid(row=4, column=0, padx=10, pady=10)
label_entry_temp.grid(row=4, column=1, padx=10, pady=10)

label_celsius.grid(row=5, column=0, padx=10, pady=10)
label_celsius_entry.grid(row=5, column=1, padx=10, pady=10)

label_wind.grid(row=6, column=0, padx=10, pady=10)
label_entry_wind.grid(row=6, column=1, padx=10, pady=10)

label_humidity.grid(row=7, column=0, padx=10, pady=10)
label_entry_humidity.grid(row=7, column=1, padx=10, pady=10)

label_descripition.grid(row=8, column=0, padx=10, pady=10)
label_entry_descripition.grid(row=8, column=1, padx=10, pady=10)

label_pressure.grid(row=9, column=0, padx=10, pady=10)
label_entry_pressure.grid(row=9, column=1, padx=10, pady=10)

Reset.grid(row=10, column=0, columnspan=3, padx=10, pady=10)

root.mainloop()


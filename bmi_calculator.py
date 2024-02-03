from tkinter import Tk,Button,Entry,Label
    
root = Tk()

entry = Entry(root)   

def bmi(weight, height):
    height=height/100
    bmi = weight/(height**2)
    return bmi

def display():
    height = float(label_entry_height.get())
    weight = float(label_entry_weight.get())
    bmi2=bmi(weight,height)
    displayarea.insert(0, bmi2)
    if bmi2 < 18.5:
        status1.insert(0,'Underweight')
    elif bmi2>=18.5 and bmi2 < 25:
        status1.insert(0,'Normal')
    elif bmi2 >= 25 and bmi2 < 30:
        status1.insert(0,'Overweight')
    else:
        status1.insert(0,'Obesity')


def reset():
    label_entry_weight.delete(0, 'end')  
    label_entry_height.delete(0, 'end')  
    displayarea.delete(0, 'end')  
    status1.delete(0, 'end')

    

label_weight = Label(root, text="Enter your weight")

label_entry_weight = Entry(root,width=20)

label_height = Label(root,text="Enter your height")

label_entry_height = Entry(root,width=20)

calcualte = Button(root, text="calculate BMI",command=display)

Reset = Button(root,text='Reset',command=reset)

Display_Area = Label(root, text="Display Area")

displayarea = Entry(root,width=20)

status = Label(root,text="BMI Status")

status1 = Entry(root,width=30)



label_weight.grid(row=0,column=0,padx=10,pady=10)

label_entry_weight.grid(row=0,column=1,padx=10,pady=10)

label_height.grid(row=1,column=0,padx=10,pady=10)

label_entry_height.grid(row=1,column=1,padx=10,pady=10)

calcualte.grid(row=2,column=0,columnspan=1,padx=10,pady=10)

Reset.grid(row=2,column=1,columnspan=3,padx=10,pady=10)

Display_Area.grid(row=3,column=0,padx=10,pady=10)

displayarea.grid(row=3,column=1,padx=10,pady=10)

status.grid(row=4,column=0,padx=10,pady=10)

status1.grid(row=4,column=1,padx=10,pady=10)

 


root.mainloop()
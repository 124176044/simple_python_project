from tkinter import Tk,Button,Entry,Label

import random
    
root = Tk()

entry = Entry(root)  

def generate_password(lowercase,uppercase,numbers,sc):
    password=""
    letters='abcdefghijklmnopqrstuvwxyz'
    letters1='ABCDEFGHIJKLMNOPQRSTUVWXYZ'
    num='0123456789'
    specialcharacters='!@#$%^&*()_+{}:"?><'
    for i in range(1,lowercase+1):
      var = random.choice(letters)
      password = password+var

    for i in range(1,uppercase+1):
      var1 = random.choice(letters1)
      password = password+var1

    for i in range(1,numbers+1):
      var2 = random.choice(num)
      password = password+var2

    for i in range(1,sc+1):
      var3 = random.choice(specialcharacters)
      password = password+var3
    return password


def display():
    lowercase = int(label_entry_lowcase.get())
    uppercase = int(label_entry_uppcase.get())
    numbers = int(label_entry_number.get())
    sc = int(label_entry_spchal.get())
    bmi2=generate_password(lowercase,uppercase,numbers,sc)
    entry_password.insert(0,bmi2)

def reset():
    label_entry_lowcase.delete(0, 'end')  
    label_entry_uppcase.delete(0, 'end')  
    label_entry_number.delete(0, 'end')  
    label_entry_spchal.delete(0, 'end')  
    entry_password.delete(0, 'end') 



label_lowcase = Label(root, text="Enter how many lowercase you want")

label_entry_lowcase = Entry(root,width=20)

label_uppcase = Label(root,text="Enter how many uppercase you want")

label_entry_uppcase = Entry(root,width=20)

label_number = Label(root,text="Enter how many number you want")

label_entry_number = Entry(root,width=20)

label_spchal = Label(root,text="Enter how many specialcharacter you want")

label_entry_spchal = Entry(root,width=20)

Gpass = Button(root, text="Generate password",command=display)

Reset = Button(root,text='Reset',command=reset)

password = Label(root,text='Generated password')

entry_password = Entry(root,width=40)




label_lowcase.grid(row=0,column=0,padx=10,pady=10)

label_entry_lowcase.grid(row=0,column=1,padx=10,pady=10)

label_uppcase.grid(row=1,column=0,padx=10,pady=10)

label_entry_uppcase.grid(row=1,column=1,padx=10,pady=10)

label_number.grid(row=2,column=0,padx=10,pady=10)

label_entry_number.grid(row=2,column=1,padx=10,pady=10)

label_spchal.grid(row=3,column=0,padx=10,pady=10)

label_entry_spchal.grid(row=3,column=1,padx=10,pady=10)

Gpass.grid(row=4,column=0,columnspan=1,padx=10,pady=10)

Reset.grid(row=4,column=1,columnspan=3,padx=10,pady=10)

password.grid(row=5,column=0,padx=10,pady=10)

entry_password.grid(row=5,column=1,padx=10,pady=10)




root.mainloop()




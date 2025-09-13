'''
Write a program to create a text file and write some content to it.
Using file functions like write and open.
'''

f = open("data.txt", "w")

f.write("This is new line.")
f.write("Happy Learning")

f.close()
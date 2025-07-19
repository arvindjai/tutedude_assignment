# We used open in read mode and file.read to read and print to display

file = open("data.txt", "r")

content = file.read()
print(content)

file.close()

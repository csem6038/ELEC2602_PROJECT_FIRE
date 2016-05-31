

load="1000"
mov="0100"
add="0010"
xor="0001"

R0="1000"
R1="0100"
R2="0010"
R3="0001"
while(1):
    binary=[]
    binary.append('0000')
    the_string = input().upper()
    command = the_string.split()
    binary.append(' ')

    if(len(command)>2):

        if (command[2]=="R0"):
            binary.append(R0)
        elif (command[2]=="R1"):
            binary.append(R1)
        elif (command[2]=="R2"):
            binary.append(R2)
        elif (command[2]=="R3"):
            binary.append(R3)
        else:
            print("Invalid register")
            binary.append('0000')
    else:
        binary.append('0000')
    binary.append(' ')


    if (command[1]=="R0"):
        binary.append(R0)
    elif (command[1]=="R1"):
        binary.append(R1)
    elif (command[1]=="R2"):
        binary.append(R2)
    elif (command[1]=="R3"):
        binary.append(R3)
    else:
        binary.append('0000')

    binary.append(' ')

    if (command[0]=="LOAD"):
        binary.append(load)
    elif (command[0]=="MOV"):
        binary.append(mov)
    elif (command[0]=="ADD"):
        binary.append(add)
    elif (command[0]=="XOR"):
        binary.append(xor)

    s = ''.join(binary)
    print(s)


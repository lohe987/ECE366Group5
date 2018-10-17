#Dissassembler for Machine Code to ISA architecture
input_file = open("project2_group_5_p1_bin.txt","r")   #Reads MachineCode here
output_file = open("project2_group_5_p1_asm.txt", "w") #Writes ISA Here

for line in input_file:
    if (line == "\n"):                   # empty lines ignored
        continue

    line = line.replace("\n","")         # remove 'endline' character
    line = line.replace(" ","")          # remove spaces anywhere in line

    if(line[1:4] =='000'):               #checks for 3 bit op-code of ADD
        op ="ADD"
        rd = format(int(line[4:6], 2))   #converts binary to decimal
        ra = format(int(line[6:8],2))
        print(op + " $R" + rd + ", $R" + ra+ "\n")  #prints ISA code
        output_file.write(op + " $R" + rd + ", $R" + ra+ "\n")
        
    elif(line[1:4] == '001'):
        op ="ADDI"
        rd = format(int(line[4:6], 2))
        if(line[6][0] =='1'):                #check if MSB in imm is 1
            imm = int(line[6:8],2)    
            imm = format(imm - 4)             #convert 2's compliment to decimal
        else:
            imm = format(int(line[6:8],2))   #if MSB in imm is 0   
        print(op + " $R" + rd + ", " + imm + "\n")
        output_file.write(op + " $R" + rd + ", " + imm + "\n")
        
    elif(line[1:4] =='010'):               #checks for 3 bit op-code of ADD
        op ="SLT"
        rd = format(int(line[4:6], 2))
        ra = format(int(line[6:8],2))
        print(op + " $R" + rd + ", $R" + ra + "\n")
        output_file.write(op + " $R" + rd + ", $R" + ra + "\n")

    elif(line[1:4] =='100'):               #line[0] (parity) is a 'dont care'
        op ="B"
        if(line[4][0] =='1'):              #check if sign bit is 1
            imm = int(line[4:8],2)    
            imm = format(imm - 16)         #convert 2's compliment to decimal
        else:
            imm = format(int(line[4:8],2)) #if sign bit is 0          
        print(op + " " + imm + "\n")
        output_file.write(op + " " + imm + "\n")

    elif(line[1:4] =='011'):
        op ="J"
        if(line[4][0] =='1'):       
            imm = int(line[4:8],2)      
            imm = format(imm - 16)
        else:
            imm = format(int(line[4:8],2))            
        print(op + " " + imm + "\n")
        output_file.write(op + " " + imm + "\n")
        
    elif(line[1:5] =='1010'):
        op ="LOAD"
        rd = format(int(line[5:7], 2))
        ra = format(int(line[7:8],2))
        print(op + " $R" + rd + ", $R" + ra + "\n")
        output_file.write(op + " $R" + rd + ", $R" + ra + "\n")
        
    elif(line[1:6] =='11001'):
        op ="NXOR"
        rd = format(int(line[6:7], 2))
        ra = format(int(line[7:8],2))
        print(op + " $R" + rd + ", $R" + ra + "\n")
        output_file.write(op + " $R" + rd + ", $R" + ra + "\n")
        
    elif(line[1:5] =='1011'):
        op ="STR"
        rd = format(int(line[5:7], 2))
        ra = format(int(line[7:8],2))
        print(op + " $R" + rd + ", $R" + ra + "\n")
        output_file.write(op + " $R" + rd + ", $R" + ra + "\n")
        
    elif(line[1:6] =='11000'):
        op ="LSL"
        rd = format(int(line[6:8],2))         
        print(op + " $R" + rd+ "\n")
        output_file.write(op + " $R" + rd+ "\n")
        
    elif(line[1:6] =='11010'):
        op ="EQZ"
        rd = format(int(line[6:8], 2))          
        print(op + " $R" + rd + "\n")
        output_file.write(op + " $R" + rd + "\n")
        
    elif(line[1:6] =='11110'):
        op ="STSH"
        rd = format(int(line[6:8], 2))          
        print(op + " $R" + rd + "\n")
        output_file.write(op + " $R" + rd + "\n")
        
    elif(line[1:6] =='11100'):
        op ="RCVR"
        rd = format(int(line[6:8], 2))          
        print(op + " $R" + rd + "\n")
        output_file.write(op + " $R" + rd + "\n")
        
    elif(line[1:6] =='11101'):
        op ="RST"
        rd = format(int(line[6:8], 2))          
        print(op + " $R" + rd + "\n")
        output_file.write(op + " $R" + rd + "\n")
        
    elif(line[1:6] =='11011'):
        op ="COMP"
        rd = format(int(line[6:8], 2))          
        print(op + " $R" + rd + "\n")
        output_file.write(op + " $R" + rd + "\n")

    elif(line[0:8] =='11111111'):
        print("End" + "\n")
        output_file.write("End" + "\n")
        
    else:                            #ignores everything else
        continue

input_file.close()
output_file.close()

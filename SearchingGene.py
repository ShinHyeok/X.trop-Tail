# X.trop-Tail
## to find overlapped gene 
 
g= open ('0.txt','w') 
 
 
def diction(name): 
    f = open(name,'r') 
    table = [] 
    for line in f: 
        table.append(line.split()[0]) 
    return table 
    f.close()
 
 
file1 = diction('toptable1.txt') 
file2 = diction('toptable2.txt') 
file3 = diction('toptable3.txt') 
 
 
for line in file1: 
    if line in file2: 
        if line in file3: 
           g.write(line+'\n') 
g.close() 

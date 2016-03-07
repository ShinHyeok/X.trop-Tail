f= open ('0.txt','r') 
g= open ('geneID1.txt','r') 
h= open ('result.txt','w') 
 
table=[] 
for line in f: 
    table.append(line) 
ID=[] 
for line in g: 
    ID.append(line) 
for line in table: 
    name = line.lower() 
    for line in ID: 
        if line.find(name) > 0: 
            h.write(line.split()[1]+'\n') 
h.close() 

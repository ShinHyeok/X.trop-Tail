# X.trop-Tail
f= open ('aln-se2.sam','r')
g= open ('aln-sam.txt','w')

table=[]
for line in f:
    table.append(line)
    
for line in table:
    match=line.split()[1]
    if match=='0':
        g.write(line)
    elif match=='16':
        g.write(line)
f.close()
g.close()

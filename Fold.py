# X.trop-Tail
f= open ('fit.txt','r')
g= open ('fold.txt','w')

table=[]
for line in f:
    table.append(line)
for line in table:
    g.write(line.split()[0]+'\t'+'1'+'\t'+str(float(line.split()[2])/float(line.split()[1]))+'\t'
            +str(float(line.split()[3])/float(line.split()[1]))+'\t'
            +str(float(line.split()[4])/float(line.split()[1]))+'\n')
g.close()

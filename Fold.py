# X.trop-Tail
f= open ('mydata.txt','r')
g= open ('fold.txt','w')

table=[]
for line in f:
    table.append(line)
for line in table:
    g.write(line.split()[0]+'\t'+str(float(line.split()[3])/float(line.split()[1]))+'\t'
            +str(float(line.split()[4])/float(line.split()[2]))+'\t'
            +str(float(line.split()[5])/float(line.split()[1]))+'\t'
            +str(float(line.split()[6])/float(line.split()[2]))+'\t'
            +str(float(line.split()[7])/float(line.split()[1]))+'\t'
            +str(float(line.split()[8])/float(line.split()[2]))+'\n')
f.close()
g.close()

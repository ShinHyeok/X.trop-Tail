##Loading library 
library(affy) 
library(limma)  
library(gplots) 

## Reda target information & normalization 
data <- ReadAffy() 
eset <- rma(data) 
data.normalized  <- normalize(data) 

## remove batch effect 
batch<-factor(c("a","b","a","b","a","b","a","b")) 
treat<-factor(c("0","0","24","24","60","60","6","6"), levels=c("0","6","24","60")) 


rmBatch<- removeBatchEffect(eset, batch=batch, design=model.matrix(~treat)) 
write.table(rmBatch,file="rmBatch.txt") 
tbl<-read.table('rmBatch.txt',header=T, row.names=1) 
hc<-hclust(as.dist(t(1-cor(tbl)))) 
plot(hc) 


# Scatter Plot 
pairs(exprs(eset)[,1:8], pch=".",main="Scatter plots",col="skyblue")  
pairs(rmBatch[,1:8], pch=".",main="Scatter plots",col="skyblue")  
pairs(fold[,1:6], pch=".",main="Fold change",col="skyblue")  

# Boxplot 
MAplot(data.normalized, pairs=TRUE, plot.method="smoothScatter") 
boxplot(data.normalized, col=c(2,2,3,3,4,4,5,5),  
        names=c("0hr_a","0hr_b","6hr_a","6hr_b","24hr_a","24hr_b","60hr_a","60hr_b"),  
        main="Boxplots of Array Express", las=2, ylab = "Intensity")  

#비교 
design <- model.matrix(~ 0+factor(c(0,0,24,24,60,60,6,6))) 
colnames(design)<- c("group1", "group2", "group3","group4")   
fit <- lmFit(rmBatch, design)   

contrast.matrix <- makeContrasts(group2-group1,group3-group2,group4-group3,group3-group1,group4-group2,group4-group1,levels=design)   
fit2 <- contrasts.fit(fit, contrast.matrix)    
fit2 <- eBayes(fit2)  




write.table(fit2,file="asdfgq.txt")

for ( i in 1:nrow(fit2) )
{
  if (fit2[i,1]$p.value<0.05)
    {r6005=r6005+1}
  if (fit2[i,4]$p.value<0.05)
    {r24005=r24005+1}
  if (fit2[i,6]$p.value<0.05)
    {r60005=r60005+1}
}

##q value =< 0.05 
d0v6<- topTable(fit2, coef=1, adjust="BH", number=r6005) 
d6v24<- topTable(fit2, coef=2, adjust="BH", number=558) 
d24v60<- topTable(fit2, coef=3, adjust="BH", number=) 
d0v24<- topTable(fit2, coef=4, adjust="BH", number=r24005) 
d0v60<- topTable(fit2, coef=6, adjust="BH", number=r60005) 


write.table(d0v6,file="0v6.txt") 
write.table(d0v24,file="0v24.txt") 
write.table(d0v60,file="0v60.txt")

##Loading library 
> library(affy) 
> library(limma)  
> library(gplots) 
 
## Reda target information & normalization 
> data <- ReadAffy() 
> eset <- rma(data) 
> data.normalized  <- normalize(data) 
 
## remove batch effect 
> batch<-factor(c("a","b","a","b","a","b","a","b")) 
> treat<-factor(c("0","0","24","24","60","60","6","6"), levels=c("0","6","24","60")) 
 
 
> rmBatch<- removeBatchEffect(eset, batch=batch, design=model.matrix(~treat)) 
> write.table(rmBatch,file="rmBatch.txt") 
> tbl<-read.table('rmBatch.txt',header=T, row.names=1) 
> hc<-hclust(as.dist(t(1-cor(tbl)))) 
> plot(hc) 
 
 
# Scatter Plot 
> pairs(exprs(eset)[,1:8], pch=".",main="Scatter plots",col="skyblue")  
> pairs(rmBatch[,1:8], pch=".",main="Scatter plots",col="skyblue")  
> pairs(fold[,1:6], pch=".",main="Fold change",col="skyblue")  
 
# Boxplot 
> MAplot(data.normalized, pairs=TRUE, plot.method="smoothScatter") 
> boxplot(data.normalized, col=c(2,2,3,3,4,4,5,5),  
   names=c("0hr_a","0hr_b","6hr_a","6hr_b","24hr_a","24hr_b","60hr_a","60hr_b"),  
   main="Boxplots of Array Express", las=2, ylab = "Intensity")  
 
#비교 
> design <- model.matrix(~ 0+factor(c(0,0,24,24,60,60,6,6))) 
>  colnames(design)<- c("group1", "group2", "group3","group4")   
>  fit <- lmFit(rmBatch, design)   
 
 
> contrast.matrix <- makeContrasts(group2-group1,group3-group2,group4-group3,group3-group1,group4-group2,group4-group1,levels=design)   
>  fit2 <- contrasts.fit(fit, contrast.matrix)    
> fit2 <- eBayes(fit2)  
 
 
##q value =< 0.01 
> Toptable1<- topTable(fit2, coef=1, adjust="BH", number=1689) 
> Toptable2<- topTable(fit2, coef=2, adjust="BH", number=558) 
> Toptable3<- topTable(fit2, coef=3, adjust="BH", number=) 
> Toptable4<- topTable(fit2, coef=4, adjust="BH", number=1942) 
> Toptable6<- topTable(fit2, coef=6, adjust="BH", number=1414) 
 
 
 
> write.table(Toptable1,file="toptable1.txt") 
> write.table(Toptable2,file="toptable2.txt") 
> write.table(Toptable3,file="toptable3.txt") 

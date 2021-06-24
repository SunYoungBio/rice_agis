setwd("F:/rice/depth_dis/")
mydata=read.table("CW08.aligned.bam.35-40X.depth.merge1k.length.count.txt")
head(mydata)
library(ggplot2)
ggplot(data = mydata,mapping = aes(x=V2,y=V1))+
  geom_point() +
  ylim(c(0,100)) + xlim(c(0,5000)) + xlab("fregment length") + ylab("count") +
  theme_bw()

mydata1=read.table("CW08.aligned.bam.35-40X.depth.merge1k.count.length.percent.bed")

head(mydata1)
ggplot(mydata1,aes(x=V6,y=V5,color=V7,size = V7)) + 
  geom_point(alpha=0.7) + theme_bw() + 
  xlab("fregment length") + ylab("36X-40X count") +
  scale_color_gradient(low = "blue",high = "red")

setwd("F:/rice/centro/3/")
mycentr=read.table("centro_perc2.txt",sep = "\t")
mycentr=read.table("all_centro_ratio.txt",sep = "\t")
mycentr=read.table("merge1-2_centro_ratio.txt",sep = "\t")
mycentr=read.table("merge21_Inhouse_241_outfmt6_80.80.merged10k.count.centrPerc.ratio.txt",sep = "\t")
mycentr=read.table("merge21_Inhouse_241_outfmt6_80.80.merged10k.count.centrPerc.ratio_maxNo.CentO.txt",sep = "\t")
head(mycentr)

library(ggplot2)
#install.packages("dplyr")
#library(ggrepel)
library(dplyr)
avg=mean(mycentr2$V10)
sd=sd(mycentr2$V10)
cutoff=avg+2*sd
cutoff0=avg-2*sd
mycentr1=mycentr
mycentr1=mycentr%>%filter(V4>9&V10<2&V10>0.01)
mycentr2=mycentr%>%filter(V4>9&V10<2&V10>0.01&V12!="O.sativa_aus"&V12!="Basm")

p <- ggplot(
  data = mycentr2,aes(x=V13,y=V10,color=V12))+
  geom_boxplot(outlier.shape = NA) + 
  geom_jitter(shape=16, position=position_jitter(0.2))+
  scale_fill_manual(values=c("#f62459", "#e08283", "#d2527f","#cf000f","#c0392b"))+
  scale_color_manual(values=c("#f62459", "#e08283", "#d2527f","#cf000f","#c0392b"))+
  #geom_text(mapping = aes(label=V4))+
  #coord_cartesian(ylim = boxplot.stats(mycentr$V9)$stats[c(1, 5)]*1.05) +
  facet_wrap(.~V7,scales = "fixed",ncol = 6)
p + coord_flip()
#p+geom_label(aes(label=V4),mycentr1,alpha=0,nudge_y = 3)
p+geom_label(aes(label=V4),mycentr2,alpha=0)+ coord_flip()

#p+ggrepel::geom_text_repel(
#  aes(label=V4,color="black"),mycentr,
#  size = 4, #注释文本的字体大小
 # box.padding = 0.5, #字到点的距离
  #point.padding = 0.8, #字到点的距离，点周围的空白宽度
  #min.segment.length = 0.5, #短线段可以省略
#  segment.color = "black", #segment.colour = NA, 不显示线段
 # show.legend = F)

#豆荚图的绘制
#install.packages("beanplot")
library("beanplot")
#library(devtools)
#install_github("kassambara/ggpubr")
#install.packages("ggpubr", repo="http://cran.us.r-project.org")
library(ggpubr)
par(las="2",mai = c(1.6, 0.5, 0.5, 0.2))
my_comparisons <- list(c("O.barthii", "O.glaberrina"), 
                       c("O.barthii", "O.rufipogon"), 
                       c("O.sativa_indica", "O.barthii"), 
                       c("O.barthii", "O.sativa_japonica"), 
                       c("O.glaberrina", "O.rufipogon"), 
                       c("O.glaberrina", "O.sativa_indica"), 
                       c("O.glaberrina", "O.sativa_japonica"), 
                       c("O.rufipogon", "O.sativa_indica"), 
                       c("O.rufipogon", "O.sativa_japonica")
                       )
beanplot(V10 ~ V7,
         data = mycentr2, ll = 0,
         #ylim = ylim, 
         col = "lightgray", border = "grey", #col = c("gray88"),
         yaxs = "i",
         what=c(1,1,1,0),
         beanlinewd = 0.5
         #main = "beanplot",
         #ylab = "body height (inch)"
         )

#add sig
ggviolin(mycentr2, x="V12", y="V10", fill = "V12", color = "V12",
         palette = c("npg"), 
         facet.by = "V7",
         add = "boxplot", add.params = list(fill="white"))+ 
  stat_compare_means(comparisons = my_comparisons, 
                     #label = "p.signif",
                     #method = "t.test"
                     method = "wilcox.test"
                     #method = "kruskal.test"
                     )+#label这里表示选择显著性标记（星号） 
  stat_compare_means(label.y = 5) 
####################################################
#filter outlier
b=boxplot(V10~V7,mycentr2)
myout=data.frame(V7=b$group,V10=b$out)
#dplyr package!!!
reout=anti_join(mycentr2,myout,by=c("V7","V10"))
mycentr3=reout
pbox=boxplot(V10~V7,mycentr3)
beanplot(V10 ~ V7,
         data = mycentr3, ll = 0,
         #ylim = ylim, 
         col = "lightgray", border = "grey", #col = c("gray88"),
         yaxs = "i",
         what=c(1,1,1,0),
         beanlinewd = 0.5
         #main = "beanplot",
         #ylab = "body height (inch)"
)
#add sig
ggviolin(mycentr3, x="V12", y="V10", fill = "V12", color = "V12",
         palette = c("rickandmorty"), x.text.angle=45,xlab = F,ylab = "ratio",legend.title = "Class",
         facet.by = "V7",
         add = "none", add.params = list(fill="white"))#+ 
  stat_compare_means(comparisons = my_comparisons, 
                     #label = "p.signif",
                     #method = "t.test"
                     method = "wilcox.test"
                     #method = "kruskal.test"
  )+#label这里表示选择显著性标记（星号） 
  stat_compare_means(label.y = 3) 
#

mywilcox.test=compare_means(V10~V12,mycentr3,paired=F,group.by = "V7",
              #ref.group = "O.barthii"
)
head(mywilcox.test1)
mywilcox.test1=data.frame(group1=paste(mywilcox.test$group1,mywilcox.test$V7,sep = "-"),
              group2=paste(mywilcox.test$group2,mywilcox.test$V7,sep = "-"),
              p=mywilcox.test$p.adj)
head(mywilcox.test1)
mytmp=data.frame(group1=paste(mywilcox.test$group2,mywilcox.test$V7,sep = "-"),
                 group2=paste(mywilcox.test$group1,mywilcox.test$V7,sep = "-"),
                 p=mywilcox.test$p.adj)
mywilcox.test.m=rbind(mywilcox.test1,mytmp)
mywilcox.test2 <- xtabs(p~group1+group2,mywilcox.test.m)
head(mywilcox.test2)
write.table(mywilcox.test2,"wilcox.test.maxtrix.txt",sep = "\t",quote = F)

library(pheatmap)
mypdata=read.table("wilcox.test.maxtrix.-log10.txt",header = T,row.names = 1)
require("RColorBrewer")
pheatmap(mypdata,scale = "none",cluster_rows = T,
         cluster_cols = T,
         #color = colorRampPalette(c("#DDDDDD", "white","red", "firebrick3"))(50),
         #color = rainbow(24),
         #color = terrain.colors(24),
         col = brewer.pal(12, "Paired"),
         display_numbers = T,
         number_format = "%.2f",
         fontsize_number = 3
         )

#install.packages("pheatmap")

ggviolin(mycentr3, x="V12", y="V10", fill = "V12", color = "V12",
         palette = c("npg"), x.text.angle=45,xlab = F,ylab = "ratio",legend.title = "Class",
         facet.by = "V7",
         add = "none", add.params = list(fill="white"))+
  compare_means(V10~V12,mycentr3,paired=F,group.by = "V7",
                #ref.group = "O.barthii"
                )%>%
  #mutate(y.position = c(1:5))%>%
  stat_pvalue_manual(label = "p.adj", 
                     #label.size=1,
                     y.position = c(1:4*0.2+1.5)) #手动添加p-value

#boxplot
p <- ggplot(
  data = mycentr3,aes(x=V13,y=V10,color=V12,fill=V12
                      ))+
  geom_boxplot(outlier.shape = NA) + 
  #geom_jitter(shape=16, position=position_jitter(0.2))+  
  #scale_fill_manual(values=c("#f62459", "#00AFBB", "#E7B800", "#FC4E07","#c0392b"))+
  #scale_color_manual(values=c("#f62459", "#00AFBB", "#E7B800", "#FC4E07","#c0392b"))+
  #scale_fill_brewer(palette = "Dark2") +
  #scale_color_brewer(palette = "Dark2") +
  ggpubr::color_palette("npg")+
  fill_palette("aaas")+
  theme_bw()+
  #theme(legend.title = element_text(colour="blue", size=10, face="bold"))+
  labs(colour = "Class")+
  labs(fill = "Classes")+
  labs(x="",y="Ratio")+
  #geom_text(mapping = aes(label=V4))+
  #coord_cartesian(ylim = boxplot.stats(mycentr$V9)$stats[c(1, 5)]*1.05) +
  facet_wrap(.~V7,scales = "fixed",ncol = 12)
p + coord_flip()
#p+geom_label(aes(label=V4),mycentr1,alpha=0,nudge_y = 3)
p+geom_label(aes(label=V4),mycentr3,alpha=0)+ coord_flip()
##################################################
hist(mycentr$V4,breaks = 3000)
df2=df1%>%filter(abs(avg_logFC_new2) > 0.3)
p+geom_label(aes(label=gene),df2,alpha=0,nudge_y = 3)
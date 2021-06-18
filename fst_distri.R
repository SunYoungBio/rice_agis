setwd("F:/rice/ONTreads2nip/fst/centro+-1M_fst/")
mydata = read.table("SV_fzc_fzw-bin100kb.centro.fst")
head(mydata)
library(ggplot2)
library(reshape2)
myfiles = list.files(pattern = "*centro.fst")
#data_all <- lapply( myfiles, read.table)

####简单绘制不同染色体的fst分布图：
for (i in myfiles) {
  mydata = read.table(i)
  mydata[,1] <- factor(mydata[,1],levels = c(paste("Chr",1:12,sep = "")))
  
  ggplot(mydata,aes(x = V2, y = V5)) + 
    #geom_point() + 
    geom_line(color="gray") +
    theme_bw() +
    facet_wrap(~V1, scales = "free") + 
    labs(title = i,x="Core Centromere +/- 1Mb",y="Fst")
  ggsave(filename = paste(i,".pdf",sep = ""), width = 15, height = 7,path = "./plots/")
 # dev.off()
}



#添加每条着丝粒的阴影区域：
#mydata1=data.frame(V1=c("Chr1"),V2=c(16700493,16700493,17133973,17133973),V3=c(0,1,1,0))
nip.centro=read.table("nip_centro.bed")	#每条染色体着丝粒的bed区间

#构建12个着丝粒的矩形区间坐标数据框，顺时针。
for (j in 1:12) {
  polygon.datafram=paste("mydata",1:12,sep = "")
  assign(polygon.datafram[j],data.frame(V1=c(nip.centro[j,1]),
                              V2=c(nip.centro[j,2],nip.centro[j,2],nip.centro[j,3],nip.centro[j,3]),
                              V3=c(0,1,1,0)))
}

#centroRegion<-function(mydatax){geom_polygon(mydatax,aes(V2, V3), fill="blue", alpha=0.2)}
for (i in myfiles) {
  mydata = read.table(i)
  newi=sub(".centro","",i)	#使用sub替换功能来修改文件名
  
  #添加每条cutoff水平线：
  fst.cutoff.file=paste(newi,".cutoff",sep = "")
  myfst.cutoff=read.table(fst.cutoff.file)	#读取每个材料的每条染色体cutoff值，两列。
  
  #构建每条染色体的cutoff水平线矩阵：
  for (n in 1:12) {
    fst.datafram=paste("myfst",1:12,sep = "")
    assign(fst.datafram[n],data.frame(V1=c(myfst.cutoff[n,1]),
                                          V2=c(myfst.cutoff[n,2])))
  }
  
  #设置绘制着丝粒时的排序：
  mydata[,1] <- factor(mydata[,1],levels = c(paste("Chr",1:12,sep = "")))
  mydata1[,1] <- factor(mydata1[,1],levels = c(paste("Chr",1:12,sep = "")))
  mydata2[,1] <- factor(mydata2[,1],levels = c(paste("Chr",1:12,sep = "")))
  mydata3[,1] <- factor(mydata3[,1],levels = c(paste("Chr",1:12,sep = "")))
  mydata4[,1] <- factor(mydata4[,1],levels = c(paste("Chr",1:12,sep = "")))
  mydata5[,1] <- factor(mydata5[,1],levels = c(paste("Chr",1:12,sep = "")))
  mydata6[,1] <- factor(mydata6[,1],levels = c(paste("Chr",1:12,sep = "")))
  mydata7[,1] <- factor(mydata7[,1],levels = c(paste("Chr",1:12,sep = "")))
  mydata8[,1] <- factor(mydata8[,1],levels = c(paste("Chr",1:12,sep = "")))
  mydata9[,1] <- factor(mydata9[,1],levels = c(paste("Chr",1:12,sep = "")))
  mydata10[,1] <- factor(mydata10[,1],levels = c(paste("Chr",1:12,sep = "")))
  mydata11[,1] <- factor(mydata11[,1],levels = c(paste("Chr",1:12,sep = "")))
  mydata12[,1] <- factor(mydata12[,1],levels = c(paste("Chr",1:12,sep = "")))

  #设置绘制fst的cutoff时的排序：：
  myfst1[,1] <- factor(myfst1[,1],levels = c(paste("Chr",1:12,sep = "")))
  myfst2[,1] <- factor(myfst2[,1],levels = c(paste("Chr",1:12,sep = "")))
  myfst3[,1] <- factor(myfst3[,1],levels = c(paste("Chr",1:12,sep = "")))
  myfst4[,1] <- factor(myfst4[,1],levels = c(paste("Chr",1:12,sep = "")))
  myfst5[,1] <- factor(myfst5[,1],levels = c(paste("Chr",1:12,sep = "")))
  myfst6[,1] <- factor(myfst6[,1],levels = c(paste("Chr",1:12,sep = "")))
  myfst7[,1] <- factor(myfst7[,1],levels = c(paste("Chr",1:12,sep = "")))
  myfst8[,1] <- factor(myfst8[,1],levels = c(paste("Chr",1:12,sep = "")))
  myfst9[,1] <- factor(myfst9[,1],levels = c(paste("Chr",1:12,sep = "")))
  myfst10[,1] <- factor(myfst10[,1],levels = c(paste("Chr",1:12,sep = "")))
  myfst11[,1] <- factor(myfst11[,1],levels = c(paste("Chr",1:12,sep = "")))
  myfst12[,1] <- factor(myfst12[,1],levels = c(paste("Chr",1:12,sep = "")))

  
  #for (a in polygon.datafram) {
   # b=get(a)
    #b[,1] <-factor(b[,1],levels = c(paste("Chr",1:12,sep = "")))
  #}
  #assign(polygon.datafram)
  #polygon.datafram.list=as.list(polygon.datafram)
  #sapply(polygon.datafram.list,within(V1 <- factor(V1,levels = c(paste("Chr",1:12,sep = "")))))
  
  #绘图：
    ggplot(mydata,aes(x = V2, y = V5)) + 
      #geom_point() + 
      geom_line(color="gray") +
      theme_bw() +
      facet_wrap(~V1, scales = "free") + 
      labs(title = i,x="Core Centromere +/- 1Mb",y="Fst") +

      geom_polygon(data=mydata1,aes(V2, V3), fill="blue", alpha=0.2) +
      geom_polygon(data=mydata2,aes(V2, V3), fill="blue", alpha=0.2) +
      geom_polygon(data=mydata3,aes(V2, V3), fill="blue", alpha=0.2) +
      geom_polygon(data=mydata4,aes(V2, V3), fill="blue", alpha=0.2) +
      geom_polygon(data=mydata5,aes(V2, V3), fill="blue", alpha=0.2) +
      geom_polygon(data=mydata6,aes(V2, V3), fill="blue", alpha=0.2) +
      geom_polygon(data=mydata7,aes(V2, V3), fill="blue", alpha=0.2) +
      geom_polygon(data=mydata8,aes(V2, V3), fill="blue", alpha=0.2) +
      geom_polygon(data=mydata9,aes(V2, V3), fill="blue", alpha=0.2) +
      geom_polygon(data=mydata10,aes(V2, V3), fill="blue", alpha=0.2) +
      geom_polygon(data=mydata11,aes(V2, V3), fill="blue", alpha=0.2) +
      geom_polygon(data=mydata12,aes(V2, V3), fill="blue", alpha=0.2) +
      geom_hline(data=myfst1,aes(yintercept=V2), colour="#990000", linetype="dashed")+
      geom_hline(data=myfst2,aes(yintercept=V2), colour="#990000", linetype="dashed")+
      geom_hline(data=myfst3,aes(yintercept=V2), colour="#990000", linetype="dashed")+
      geom_hline(data=myfst4,aes(yintercept=V2), colour="#990000", linetype="dashed")+
      geom_hline(data=myfst5,aes(yintercept=V2), colour="#990000", linetype="dashed")+
      geom_hline(data=myfst6,aes(yintercept=V2), colour="#990000", linetype="dashed")+
      geom_hline(data=myfst7,aes(yintercept=V2), colour="#990000", linetype="dashed")+
      geom_hline(data=myfst8,aes(yintercept=V2), colour="#990000", linetype="dashed")+
      geom_hline(data=myfst9,aes(yintercept=V2), colour="#990000", linetype="dashed")+
      geom_hline(data=myfst10,aes(yintercept=V2), colour="#990000", linetype="dashed")+
      geom_hline(data=myfst11,aes(yintercept=V2), colour="#990000", linetype="dashed")+
      geom_hline(data=myfst12,aes(yintercept=V2), colour="#990000", linetype="dashed")
    
    ggsave(filename = paste(i,".pdf",sep = ""), width = 15, height = 7,path = "./plots/")
}



centroRegion(mydata1)
lapply(centro.list,centroRegion)


ggplot(mydata,aes(x = V2, y = V5)) + 
  #geom_point() + 
  geom_line(color="gray") +
  theme_bw() +
  facet_wrap(~V1, scales = "free") + 
  labs(title = i,x="Core Centromere +/- 1Mb",y="Fst") +
  #geom_text(data=mydata1,x=16700000,y=V2,aes(label=label))
  geom_polygon(data=mydata1, aes(V2, V3), fill="blue", alpha=0.2)
  
  
  
  geom_rect(data=mydata1,
            aes(xmin=16700493, xmax=17133973, 
                           ymin=-Inf, ymax=Inf),fill='#FF3300',alpha = .02)

geom_rect(aes(xmin=3, xmax=4.2, ymin=-Inf, ymax=Inf),fill='#FF3300',alpha = .02)
Chr1	16700493	17133973
Chr2	13579135	13757297
Chr3	19541426	19579915
Chr4	9756392	9880640
Chr5	12458311	12555470
Chr6	15424582	15490283
Chr7	11961001	12281283
Chr8	12920584	12996740
Chr9	2750493	2980954
Chr10	8099807	8195294
Chr11	12045463	12329492
Chr12	11772805	12070839


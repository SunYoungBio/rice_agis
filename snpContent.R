library(ggplot2)
setwd("F:/rice/hehuiying/")
mytra.down=read.table("nonTRA_in_centro.tr.class.plot.txt")
head(mytra.down)
p=ggplot(data=mytra.down, mapping=aes(x="V3",fill=V3))+
  geom_bar(stat="count",
           #position='fill',
           #position='stack',
           position='dodge',
           width=0.5)+
  facet_grid(V1~V2)+
  #coord_polar(theta = "y") + 
  geom_text(stat='count',aes(label=..count..), color="black", size=1,
            position=position_dodge(0.5),
            vjust=0.5
            )+
  labs(x = "", y = "", title = "") +
  theme(axis.ticks = element_blank()) + 
  #theme(legend.title = element_blank(), legend.position = "left") + 
  theme(axis.text.x = element_blank())+
  theme(axis.text.y = element_blank())+
  theme(panel.grid=element_blank()) +    
  theme(panel.border=element_blank())+  
  scale_fill_manual(values=c("#56B4E9","#999999","red" ,"blue"))+
  theme(strip.text.x = element_text(size=3,angle = 90),
        strip.text.y = element_text(size=3,angle = 0),
        #strip.background = element_rect(colour=NA, fill=NA)
  )


p=ggplot(data=mytra.down, mapping=aes(x="V3",fill=V3))+facet_grid(V1~V2)+
  geom_text(stat='count',aes(label=..count..), color="black", size=1,
    position=position_dodge(0.5),
    vjust=0.5
)

pg <- ggplot_build(p)

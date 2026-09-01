
require(ggplot2)
require(ggpubr)
require(ggpubr)
require(readxl)
require(dplyr)

ds.birds.m <- readRDS("./draws_captured_hunted_mgene.RDS")
ds.birds.h5 <- readRDS("./draws_captured_hunted_h5.RDS")
ds.birds.h5hpai <- readRDS("./draws_captured_hunted_h5_hpai.RDS")
ds.surv <- readRDS("./draws/draws_surveillance_mgene.RDS")


# Plot estimated Se for captured and hunted bird sample types (M gene)
windows()
fit.birds.m <- as.data.frame(ds.birds.m)
fit.birds.m$Sensitivity_Tracheal <- mean(fit.birds.m$'1.Sensitivity_Tracheal',fit.birds.m$'2.Sensitivity_Tracheal',fit.birds.m$'3.Sensitivity_Tracheal',fit.birds.m$'4.Sensitivity_Tracheal')
fit.birds.m$Sensitivity_Cloacal <- mean(fit.birds.m$'1.Sensitivity_Cloacal',fit.birds.m$'2.Sensitivity_Cloacal',fit.birds.m$'3.Sensitivity_Cloacal',fit.birds.m$'4.Sensitivity_Cloacal')
fit.birds.m$Sensitivity_Feather <- mean(fit.birds.m$'1.Sensitivity_Feather',fit.birds.m$'2.Sensitivity_Feather',fit.birds.m$'3.Sensitivity_Feather',fit.birds.m$'4.Sensitivity_Feather')
fit.birds.m$Sensitivity_Brain <- mean(fit.birds.m$'1.Sensitivity_Brain',fit.birds.m$'2.Sensitivity_Brain',fit.birds.m$'3.Sensitivity_Brain',fit.birds.m$'4.Sensitivity_Brain')
fit.birds.m.sensitivity <- fit.birds.m  %>% 
  select(-c('1.lp__','2.lp__','3.lp__','4.lp__')) %>%
  select(c(Sensitivity_Tracheal, Sensitivity_Cloacal, Sensitivity_Feather,Sensitivity_Brain))%>%
  tidyr::pivot_longer(everything()) %>%
  mutate(name = factor(name, levels = c("Sensitivity_Tracheal",
                                        "Sensitivity_Cloacal",
                                        "Sensitivity_Feather",
                                        "Sensitivity_Brain"))) %>%
  ggplot(aes(name, value)) +
  geom_violin(aes(fill = name)) +
  scale_y_continuous(limits = c(0, 1)) +
  scale_x_discrete(breaks = c("Sensitivity_Tracheal", "Sensitivity_Cloacal", "Sensitivity_Feather","Sensitivity_Brain"),
                   labels = c("Oropharyngeal swab","Cloacal swab","Feather swab","Brain sample")) +
  scale_fill_manual(values = c("#1b9e77","#d95f02","#D3D3D3","#e7298a","#7570b3")) +
  theme(panel.grid.major.y = element_line(linetype = "dotted", colour = "grey70"),
        axis.text.x = element_text(angle = 90, vjust = 0.5, hjust = 1, size = 12),
        axis.text.y = element_text(size = 12),
        axis.title.y = element_text(size = 14, margin = margin(0,10,0,0)),
        axis.title.x = element_blank(),
        plot.title = element_text(size = 14),
        legend.position = "none",
        panel.background = element_rect(fill = "white", colour = "grey70")) +
  ylab("Sensitivity") +
  theme(plot.margin = margin(5,5,5,5)) +
  ggtitle("M gene")
fit.birds.m.sensitivity


# Plot estimated Se for captured and hunted bird sample types (H5)
windows()
fit.birds.h5 <- as.data.frame(ds.birds.h5)
fit.birds.h5$Sensitivity_Tracheal <- mean(fit.birds.h5$'1.Sensitivity_Tracheal',fit.birds.h5$'2.Sensitivity_Tracheal',fit.birds.h5$'3.Sensitivity_Tracheal',fit.birds.h5$'4.Sensitivity_Tracheal')
fit.birds.h5$Sensitivity_Cloacal <- mean(fit.birds.h5$'1.Sensitivity_Cloacal',fit.birds.h5$'2.Sensitivity_Cloacal',fit.birds.h5$'3.Sensitivity_Cloacal',fit.birds.h5$'4.Sensitivity_Cloacal')
fit.birds.h5$Sensitivity_Feather <- mean(fit.birds.h5$'1.Sensitivity_Feather',fit.birds.h5$'2.Sensitivity_Feather',fit.birds.h5$'3.Sensitivity_Feather',fit.birds.h5$'4.Sensitivity_Feather')
fit.birds.h5$Sensitivity_Brain <- mean(fit.birds.h5$'1.Sensitivity_Brain',fit.birds.h5$'2.Sensitivity_Brain',fit.birds.h5$'3.Sensitivity_Brain',fit.birds.h5$'4.Sensitivity_Brain')
fit.birds.h5.sensitivity <- fit.birds.h5  %>% 
  select(-c('1.lp__','2.lp__','3.lp__','4.lp__')) %>%
  select(c(Sensitivity_Tracheal, Sensitivity_Cloacal, Sensitivity_Feather,Sensitivity_Brain))%>%
  tidyr::pivot_longer(everything()) %>%
  mutate(name = factor(name, levels = c("Sensitivity_Tracheal",
                                        "Sensitivity_Cloacal",
                                        "Sensitivity_Feather",
                                        "Sensitivity_Brain"))) %>%
  ggplot(aes(name, value)) +
  geom_violin(aes(fill = name)) +
  scale_y_continuous(limits = c(0, 1)) +
  scale_x_discrete(breaks = c("Sensitivity_Tracheal", "Sensitivity_Cloacal", "Sensitivity_Feather","Sensitivity_Brain"),
                   labels = c("Oropharyngeal swab","Cloacal swab","Feather swab","Brain sample")) +
  scale_fill_manual(values = c("#1b9e77","#d95f02","#D3D3D3","#e7298a","#7570b3")) +
  theme(panel.grid.major.y = element_line(linetype = "dotted", colour = "grey70"),
        axis.text.x = element_text(angle = 90, vjust = 0.5, hjust = 1, size = 12),
        axis.text.y = element_blank(),
        axis.ticks.y = element_blank(),
        axis.title.y = element_blank(),
        axis.title.x = element_blank(),
        plot.title = element_text(size = 14),
        legend.position = "none",
        panel.background = element_rect(fill = "white", colour = "grey70")) +
  ylab("Sensitivity") +
  theme(plot.margin = margin(5,5,5,5)) +
  ggtitle("H5")
fit.birds.h5.sensitivity


# Plot estimated Se for captured and hunted bird sample types (H5 HPAI)
windows()
fit.birds.h5hpai <- as.data.frame(ds.birds.h5hpai)
fit.birds.h5hpai$Sensitivity_Tracheal <- mean(fit.birds.h5hpai$'1.Sensitivity_Tracheal',fit.birds.h5hpai$'2.Sensitivity_Tracheal',fit.birds.h5hpai$'3.Sensitivity_Tracheal',fit.birds.h5hpai$'4.Sensitivity_Tracheal')
fit.birds.h5hpai$Sensitivity_Cloacal <- mean(fit.birds.h5hpai$'1.Sensitivity_Cloacal',fit.birds.h5hpai$'2.Sensitivity_Cloacal',meanfit.birds.h5hpai$'3.Sensitivity_Cloacal',fit.birds.h5hpai$'4.Sensitivity_Cloacal')
fit.birds.h5hpai$Sensitivity_Feather <- mean(fit.birds.h5hpai$'1.Sensitivity_Feather',fit.birds.h5hpai$'2.Sensitivity_Feather',fit.birds.h5hpai$'3.Sensitivity_Feather',fit.birds.h5hpai$'4.Sensitivity_Feather')
fit.birds.h5hpai$Sensitivity_Brain <- mean(fit.birds.h5hpai$'1.Sensitivity_Brain',fit.birds.h5hpai$'2.Sensitivity_Brain',fit.birds.h5hpai$'3.Sensitivity_Brain',fit.birds.h5hpai$'4.Sensitivity_Brain')
fit.birds.h5hpai.sensitivity <- fit.birds.h5hpai  %>% 
  select(-c('1.lp__','2.lp__','3.lp__','4.lp__')) %>%
  select(c(Sensitivity_Tracheal, Sensitivity_Cloacal, Sensitivity_Feather,Sensitivity_Brain))%>%
  tidyr::pivot_longer(everything()) %>%
  mutate(name = factor(name, levels = c("Sensitivity_Tracheal",
                                        "Sensitivity_Cloacal",
                                        "Sensitivity_Feather",
                                        "Sensitivity_Brain"))) %>%
  ggplot(aes(name, value)) +
  geom_violin(aes(fill = name)) +
  scale_y_continuous(limits = c(0, 1)) +
  scale_x_discrete(breaks = c("Sensitivity_Tracheal", "Sensitivity_Cloacal", "Sensitivity_Feather","Sensitivity_Brain"),
                   labels = c("Oropharyngeal swab","Cloacal swab","Feather swab","Brain sample")) +
  scale_fill_manual(values = c("#1b9e77","#d95f02","#D3D3D3","#e7298a","#7570b3")) +
  theme(panel.grid.major.y = element_line(linetype = "dotted", colour = "grey70"),
        axis.text.x = element_text(angle = 90, vjust = 0.5, hjust = 1, size = 12),
        axis.text.y = element_blank(),
        axis.ticks.y = element_blank(),
        axis.title.y = element_blank(),
        axis.title.x = element_blank(),
        plot.title = element_text(size = 14),
        legend.position = "none",
        panel.background = element_rect(fill = "white", colour = "grey70")) +
  ylab("Sensitivity") +
  theme(plot.margin = margin(5,5,5,5)) +
  ggtitle("H5 HPAI")
fit.birds.h5hpai.sensitivity

ggarrange(fit.birds.m.sensitivity, fit.birds.h5.sensitivity, fit.birds.h5hpai.sensitivity, nrow = 1,  widths = c(1, 1, 1), common.legend = FALSE)
ggsave("./Figure_2.png", device = "png", dpi = 300, width = 8, height = 6, units = "in")


#----------------------------------------------------------------------------------------------------------------------------------------------------
# Plot estimated Se for bird- and environmental-based surveillance stategies (M gene)
fit.surv <- as.data.frame(ds.surv)
fit.surv$Sensitivity_Captured <- mean(fit.surv$'1.Sensitivity_Captured',fit.surv$'2.Sensitivity_Captured',fit.surv$'3.Sensitivity_Captured',fit.surv$'4.Sensitivity_Captured')
fit.surv$Sensitivity_Hunted <- mean(fit.surv$'1.Sensitivity_Hunted',fit.surv$'2.Sensitivity_Hunted',fit.surv$'3.Sensitivity_Hunted',fit.surv$'4.Sensitivity_Hunted')
fit.surv$Sensitivity_Faeces <- mean(fit.surv$'1.Sensitivity_Faeces',fit.surv$'2.Sensitivity_Faeces',fit.surv$'3.Sensitivity_Faeces',fit.surv$'4.Sensitivity_Faeces')
fit.surv$Sensitivity_Water <- mean(fit.surv$'1.Sensitivity_Water',fit.surv$'2.Sensitivity_Water',fit.surv$'3.Sensitivity_Water',fit.surv$'4.Sensitivity_Water')
fit.surv$Sensitivity_Feathers <- mean(fit.surv$'1.Sensitivity_Feathers',fit.surv$'2.Sensitivity_Feathers',fit.surv$'3.Sensitivity_Feathers',fit.surv$'4.Sensitivity_Feathers')

fit.surv.sensitivity <- fit.surv  %>% 
  select(-c('1.lp__','2.lp__','3.lp__','4.lp__')) %>%
  select(c(Sensitivity_Captured, Sensitivity_Hunted, Sensitivity_Faeces,Sensitivity_Water,Sensitivity_Feathers))%>%
  tidyr::pivot_longer(everything()) %>%
  mutate(name = factor(name, levels = c("Sensitivity_Captured", 
                                        "Sensitivity_Hunted",
                                        "Sensitivity_Feathers",
                                        "Sensitivity_Faeces",
                                        "Sensitivity_Water"))) %>%
  ggplot(aes(name, value)) +
  geom_violin(aes(fill = name)) +
  scale_y_continuous(limits = c(0, 1)) +
  scale_x_discrete(breaks = c("Sensitivity_Captured", "Sensitivity_Hunted", "Sensitivity_Faeces","Sensitivity_Water","Sensitivity_Feathers"),
                   labels = c("Captured birds\n(OS, CS)","Hunted birds\n(OS, CS, BST)","Faecal droppings","Surface water","Feather swabs")) +
  scale_fill_manual(breaks = c("Sensitivity_Captured", "Sensitivity_Hunted", "Sensitivity_Faeces","Sensitivity_Water","Sensitivity_Feathers"),
                    values = c("#e6ab02","#a6761d","#666666","#1f78b4","#b2df8a")) +
  theme(panel.grid.major.y = element_line(linetype = "dotted", colour = "grey70"),
        axis.text.x = element_text(angle = 90, vjust = 0.5, hjust = 1, size = 12),
        axis.text.y = element_text(size = 12),
        axis.title.y = element_text(size = 14, margin = margin(0,10,0,0)),
        axis.title.x = element_blank(),
        plot.title = element_text(size = 14),
        legend.position = "none",
        panel.background = element_rect(fill = "white", colour = "grey70")) +
  ylab("Sensitivity") +
  theme(plot.margin = margin(5,5,5,5)) +
  ggtitle("M gene")
fit.surv.sensitivity
ggsave("./Figure_3.png", device = "png", dpi = 300, width = 4, height = 7, units = "in")

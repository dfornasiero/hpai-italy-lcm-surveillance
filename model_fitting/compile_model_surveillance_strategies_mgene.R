library(cmdstanr)
library(readxl)
library(dplyr)
library(ggplot2)
library(bayesplot)
library(posterior)

setwd("./")

## MODEL
model <- readRDS("./model_surveillance_strategy_mgene.rds")

# Import data
ds1 <- readRDS("./ds_surveillance_strategy_mgene.RDS")
table(ds1$test_pattern) # no. patterns
length(table(ds1$test_pattern)) # no. (sub)populations

# head(ds_surveillance_strategy_mgene)
#   date        group           gene_m_captured gene_m_hunted gene_m_faeces gene_m_water gene_m_feathers test_pattern
# 1 2024-09-17  Inland areas                 NA             0            NA           NA              NA 01000       
# 2 2024-09-23  Inland areas                 NA             0            NA           NA              NA 01000       
# 3 2024-09-24  Venetian lagoon               1            NA            NA           NA               1 10001       
# 4 2024-09-30  Inland areas                 NA             0            NA           NA              NA 01000       
# 5 2024-10-01  Venetian lagoon               1            NA             0            1               0 10111       
# 6 2024-10-02  Inland areas                 NA             0            NA           NA              NA 01000 


data_list <- list(p1s4 = ds1[ds1$test_pattern == "00010",][["gene_m_water"]],
                  p2s3 = ds1[ds1$test_pattern == "00100",][["gene_m_faeces"]],
                  p3s3 = ds1[ds1$test_pattern == "00110",][["gene_m_faeces"]],
                  p3s4 = ds1[ds1$test_pattern == "00110",][["gene_m_water"]],
                  p4s2 = ds1[ds1$test_pattern == "01000",][["gene_m_hunted"]],
                  p5s2 = ds1[ds1$test_pattern == "01001",][["gene_m_hunted"]],
                  p5s5 = ds1[ds1$test_pattern == "01001",][["gene_m_feathers"]],
                  p6s2 = ds1[ds1$test_pattern == "01100",][["gene_m_hunted"]],
                  p6s3 = ds1[ds1$test_pattern == "01100",][["gene_m_faeces"]],
                  p7s2 = ds1[ds1$test_pattern == "01110",][["gene_m_hunted"]],
                  p7s3 = ds1[ds1$test_pattern == "01110",][["gene_m_faeces"]],
                  p7s4 = ds1[ds1$test_pattern == "01110",][["gene_m_water"]],
                  p8s1 = ds1[ds1$test_pattern == "10001",][["gene_m_captured"]],
                  p8s5 = ds1[ds1$test_pattern == "10001",][["gene_m_feathers"]],
                  p9s1 = ds1[ds1$test_pattern == "10011",][["gene_m_captured"]],
                  p9s4 = ds1[ds1$test_pattern == "10011",][["gene_m_water"]],
                  p9s5 = ds1[ds1$test_pattern == "10011",][["gene_m_feathers"]],
                  p10s1 = ds1[ds1$test_pattern == "10111",][["gene_m_captured"]],
                  p10s3 = ds1[ds1$test_pattern == "10111",][["gene_m_faeces"]],
                  p10s4 = ds1[ds1$test_pattern == "10111",][["gene_m_water"]],
                  p10s5 = ds1[ds1$test_pattern == "10111",][["gene_m_feathers"]],
                  p11s1 = ds1[ds1$test_pattern == "11011",][["gene_m_captured"]],
                  p11s2 = ds1[ds1$test_pattern == "11011",][["gene_m_hunted"]],
                  p11s4 = ds1[ds1$test_pattern == "11011",][["gene_m_water"]],
                  p11s5 = ds1[ds1$test_pattern == "11011",][["gene_m_feathers"]],
                  M1 = 1,
                  M2 = 1,
                  M3 = 2,
                  M4 = 1,
                  M5 = 2,
                  M6 = 2,
                  M7 = 3,
                  M8 = 2,
                  M9 = 3,
                  M10 = 4,
                  M11 = 4,
                  N1 = nrow(ds1[ds1$test_pattern == "00010",]),
                  N2 = nrow(ds1[ds1$test_pattern == "00100",]),
                  N3 = nrow(ds1[ds1$test_pattern == "00110",]),
                  N4 = nrow(ds1[ds1$test_pattern == "01000",]),
                  N5 = nrow(ds1[ds1$test_pattern == "01001",]),
                  N6 = nrow(ds1[ds1$test_pattern == "01100",]),
                  N7 = nrow(ds1[ds1$test_pattern == "01110",]),
                  N8 = nrow(ds1[ds1$test_pattern == "10001",]),
                  N9 = nrow(ds1[ds1$test_pattern == "10011",]),
                  N10 = nrow(ds1[ds1$test_pattern == "10111",]),
                  N11 = nrow(ds1[ds1$test_pattern == "11011",])
                  )

#----------------------------------------------------------------------------------------------------- 
# Fit the model to the data
fit <- model$sample(data = data_list,
                    chains = 4,
                    iter_warmup = 1000,
                    iter_sampling = 2000,
                    parallel_chains = 4,
                    seed = 777)
draws <- fit$draws()
saveRDS(draws, "./draws_surveillance_mgene.RDS")

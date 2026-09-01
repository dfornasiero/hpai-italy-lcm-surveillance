library(cmdstanr)
library(readxl)
library(dplyr)
library(ggplot2)
library(bayesplot)
library(posterior)

setwd("./")

## MODEL
model <- readRDS("./model_captured_hunted_h5_hpai.rds")

# Import data
ds1 <- readRDS("./ds_captured_hunted_h5_hpai.RDS")
table(ds1$test_pattern, ds1$group) # no. patterns per group
table(ds1$test_pattern) # no. patterns
length(table(ds1$test_pattern)) # no. (sub)populations

# head(ds_captured_hunted_h5_hpai)
#   id     date       tt_h5_hpai tc_h5_hpai tp_h5_hpai brain_h5_hpai group    test_pattern
# 1 CK7936 2025-02-25          0          0          0            NA Captured 1110        
# 2 CK8105 2024-11-05          0          0          0            NA Captured 1110        
# 3 CK8106 2024-11-19          0          0          0            NA Captured 1110        
# 4 CK8107 2024-11-19          0          0          0            NA Captured 1110        
# 5 CK8108 2024-11-19          0          0          0            NA Captured 1110        
# 6 CK8109 2024-12-17          0          0          0            NA Captured 1110    


data_list <- list(p1t4 = ds1[ds1$test_pattern == "0001",][["brain_h5_hpai"]],
                  p2t3 = ds1[ds1$test_pattern == "0010",][["tp_h5_hpai"]],
                  p3t2 = ds1[ds1$test_pattern == "0100",][["tc_h5_hpai"]],
                  p4t1 = ds1[ds1$test_pattern == "1000",][["tt_h5_hpai"]],
                  p5t1 = ds1[ds1$test_pattern == "1001",][["tt_h5_hpai"]],
                  p5t4 = ds1[ds1$test_pattern == "1001",][["brain_h5_hpai"]],
                  p6t1 = ds1[ds1$test_pattern == "1010",][["tt_h5_hpai"]],
                  p6t3 = ds1[ds1$test_pattern == "1010",][["tp_h5_hpai"]],
                  p7t1 = ds1[ds1$test_pattern == "1100",][["tt_h5_hpai"]],
                  p7t2 = ds1[ds1$test_pattern == "1100",][["tc_h5_hpai"]],
                  p8t1 = ds1[ds1$test_pattern == "1110",][["tt_h5_hpai"]],
                  p8t2 = ds1[ds1$test_pattern == "1110",][["tc_h5_hpai"]],
                  p8t3 = ds1[ds1$test_pattern == "1110",][["tp_h5_hpai"]],
                  M1 = 1,
                  M2 = 1,
                  M3 = 1,
                  M4 = 1,
                  M5 = 2,
                  M6 = 2,
                  M7 = 2,
                  M8 = 3,
                  N1 = nrow(ds1[ds1$test_pattern == "0001",]),
                  N2 = nrow(ds1[ds1$test_pattern == "0010",]),
                  N3 = nrow(ds1[ds1$test_pattern == "0100",]),
                  N4 = nrow(ds1[ds1$test_pattern == "1000",]),
                  N5 = nrow(ds1[ds1$test_pattern == "1001",]),
                  N6 = nrow(ds1[ds1$test_pattern == "1010",]),
                  N7 = nrow(ds1[ds1$test_pattern == "1100",]),
                  N8 = nrow(ds1[ds1$test_pattern == "1110",])
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
saveRDS(draws, "./draws_captured_hunted_h5_hpai.RDS")

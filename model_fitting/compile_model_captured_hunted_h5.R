library(cmdstanr)
library(readxl)
library(dplyr)
library(ggplot2)
library(bayesplot)
library(posterior)

setwd("./")

## MODEL
model <- readRDS("./model_captured_hunted_h5.rds")

# Import data
ds1 <- readRDS("./ds_captured_hunted_h5.RDS")
table(ds1$test_pattern, ds1$group) # no. patterns per group
table(ds1$test_pattern) # no. patterns
length(table(ds1$test_pattern)) # no. (sub)populations

head(ds_captured_hunted_h5)
#             id       date tt_h5 tc_h5 tp_h5 brain_h5  group test_pattern
# 1  24/138884/1 2024-10-08     0    NA    NA       NA Hunted         1000
# 2 24/138884/10 2024-10-08     0    NA    NA       NA Hunted         1000
# 3 24/138884/11 2024-10-08     0    NA    NA       NA Hunted         1000
# 4 24/138884/12 2024-10-08     0    NA    NA       NA Hunted         1000
# 5 24/138884/13 2024-10-08     0    NA    NA       NA Hunted         1000
# 6 24/138884/14 2024-10-08     0    NA    NA       NA Hunted         1000

data_list <- list(p1t4 = ds1[ds1$test_pattern == "0001",][["brain_h5"]],
                  p2t3 = ds1[ds1$test_pattern == "0010",][["tp_h5"]],
                  p3t2 = ds1[ds1$test_pattern == "0100",][["tc_h5"]],
                  p4t1 = ds1[ds1$test_pattern == "1000",][["tt_h5"]],
                  p5t1 = ds1[ds1$test_pattern == "1001",][["tt_h5"]],
                  p5t4 = ds1[ds1$test_pattern == "1001",][["brain_h5"]],
                  p6t1 = ds1[ds1$test_pattern == "1010",][["tt_h5"]],
                  p6t3 = ds1[ds1$test_pattern == "1010",][["tp_h5"]],
                  p7t1 = ds1[ds1$test_pattern == "1100",][["tt_h5"]],
                  p7t2 = ds1[ds1$test_pattern == "1100",][["tc_h5"]],
                  p8t1 = ds1[ds1$test_pattern == "1110",][["tt_h5"]],
                  p8t2 = ds1[ds1$test_pattern == "1110",][["tc_h5"]],
                  p8t3 = ds1[ds1$test_pattern == "1110",][["tp_h5"]],
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
                    seed = 890)


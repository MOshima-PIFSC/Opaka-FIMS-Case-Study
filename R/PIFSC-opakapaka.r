## Script to run Opakapaka case study in FIMS. 
## Created by Meg Oshima

library(dplyr)
library(tidyr)
library(ggplot2)
require(FIMS)
library(TMB)
# devtools::install_github("kaskr/TMB_contrib_R/TMBhelper")
library(TMBhelper)
# remotes::install_github("r4ss/r4ss")
require(r4ss)

## Version documentation
R_version <- version$version.string
TMB_version <- packageDescription("TMB")$Version
FIMS_commit <- substr(packageDescription("FIMS")$GithubSHA1, 1, 7)

## Model path
ss_dir <- file.path(getwd(), "Model", "06_no_missing_data")

## Read in SS input files
ss3dat <- r4ss::SS_readdat_3.30(file = file.path(ss_dir, "data.ss"))
ss3ctl <- r4ss::SS_readctl_3.30(file = file.path(ss_dir, "control.ss"))
## Function written by Ian Taylor to get SS3 data into FIMSframeAge format
source("./R/get_ss3_data.r")

## Define the dimensions
### years from 1949 to 2023
years <- seq(ss3dat$styr, ss3dat$endyr)
nyears <- length(years)
nseasons <- 1
ages <- ss3dat$agebin_vector
nages <- length(ages)

head(data_mile1)
## Use R/get_ss3_data function to get from data.ss to FIMSframeAge
opaka_dat <- get_ss3_data(ss3dat, fleets = c(1,2,3,4))




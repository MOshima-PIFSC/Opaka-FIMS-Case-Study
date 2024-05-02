## This script creates an Opaka SS3 model, using ss3sim. The model is based on Opaka population dynamics, however, because of the requirement of age data for FIMS, and the lack of real age comp data for Opaka, I used the simulated model developed for another Opaka simulation study. I used the historical F timeseries from the Opaka model to simulate the catch, CPUE, and age comp data for the commercial fishery fleet, and the selectivity for the BFISH camera survey fleet to generate length comp and age comp data. 
library(ss3sim)
library(r4ss)

main_dir <- getwd()
om_dir <- file.path(main_dir, "Model", "cod-om")
em_dir <- file.path(main_dir, "Model", "cod-em")
rep <- SS_output(file.path(main_dir, "Model", "08-modified-for-ss3sim"))
F_frs <- rep$exploitation$FRS

F_fims <- list(
  years = list(1:75),
  fleets = c(1), 
  fvals = list(F_frs)
)

index_fims <- list(
  fleets = c(1,2), years = list(seq(1, 75, by = 1), seq(69, 75, by = 1)),
  seas = list(7,1), sds_obs = list(0.1, 0.25)
)

lcomp_fims <- list(
  fleets = c(2), Nsamp = list(45),
  years = list(seq(69, 75, by = 1))
)

agecomp_fims <- list(
  fleets = c(1,2), Nsamp = list(100,45),
  years = list(seq(26, 75, by = 1), seq(69, 75, by = 1))
)

ss3sim_base(
  iterations = 1,
  scenarios = "FIMS-em", 
  f_params = F_fims,
  index_params = index_fims,
  lcomp_params = lcomp_fims,
  agecomp_params = agecomp_fims,
  om_dir = om_dir,
  em_dir = em_dir
)
#move the files over into /Model directory once runs

ss3dat <- SS_readdat_3.30(file.path(main_dir, "Model", "FIMS-em", "1", "em", "ss3.dat"))
ss3ctl <- SS_readctl_3.30(file.path(main_dir, "Model", "FIMS-em", "1", "em", "em.ctl"), use_datlist = TRUE, datlist = file.path(main_dir, "Model", "FIMS-em", "1", "em", "ss3.dat"))
rep <- SS_output(file.path(main_dir, "Model", "FIMS-em", "1", "em"))
weights <- rep$wtatage |> 
dplyr::filter(Sex == 1 & Fleet == 1 & Yr == 1) |> 
dplyr::select(paste(1:43)) |> 
round(4)

save(list = c("ss3dat", "ss3ctl", "weights"), file = file.path(getwd(), "Model", "FIMS-em", "1", "em", "opaka_model.RDS"))

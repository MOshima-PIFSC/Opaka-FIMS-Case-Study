#V3.30.21.00;_fast(opt);_compile_date:_Feb 10 2023;_Stock_Synthesis_by_Richard_Methot_(NOAA)_using_ADMB_13.1
#_Stock_Synthesis_is_a_work_of_the_U.S._Government_and_is_not_subject_to_copyright_protection_in_the_United_States.
#_Foreign_copyrights_may_apply._See_copyright.txt_for_more_information.
#_User_support_available_at:NMFS.Stock.Synthesis@noaa.gov
#_User_info_available_at:https://vlab.noaa.gov/group/stock-synthesis
#_Source_code_at:_https://github.com/nmfs-stock-synthesis/stock-synthesis
#C growth parameters are estimated
#C spawner-recruitment bias adjustment Not tuned For optimality
#_data_and_control_files: data.ss // control.ss
0  # 0 means do not read wtatage.ss; 1 means read and use wtatage.ss and also read and use growth parameters
1  #_N_Growth_Patterns (Growth Patterns, Morphs, Bio Patterns, GP are terms used interchangeably in SS3)
1 #_N_platoons_Within_GrowthPattern 
#_Cond 1 #_Platoon_within/between_stdev_ratio (no read if N_platoons=1)
#_Cond  1 #vector_platoon_dist_(-1_in_first_val_gives_normal_approx)
#
4 # recr_dist_method for parameters:  2=main effects for GP, Area, Settle timing; 3=each Settle entity; 4=none (only when N_GP*Nsettle*pop==1)
1 # not yet implemented; Future usage: Spawner-Recruitment: 1=global; 2=by area
1 #  number of recruitment settlement assignments 
0 # unused option
#GPattern month  area  age (for each settlement assignment)
 1 1 1 0
#
#_Cond 0 # N_movement_definitions goes here if Nareas > 1
#_Cond 1.0 # first age that moves (real age at begin of season, not integer) also cond on do_migration>0
#_Cond 1 1 1 2 4 10 # example move definition for seas=1, morph=1, source=1 dest=2, age1=4, age2=10
#
0 #_Nblock_Patterns
#_Cond 0 #_blocks_per_pattern 
# begin and end years of blocks
#
# controls for all timevary parameters 
1 #_time-vary parm bound check (1=warn relative to base parm bounds; 3=no bound check); Also see env (3) and dev (5) options to constrain with base bounds
#
# AUTOGEN
 0 0 0 0 0 # autogen: 1st element for biology, 2nd for SR, 3rd for Q, 4th reserved, 5th for selex
# where: 0 = autogen time-varying parms of this category; 1 = read each time-varying parm line; 2 = read then autogen if parm min==-12345
#
#_Available timevary codes
#_Block types: 0: P_block=P_base*exp(TVP); 1: P_block=P_base+TVP; 2: P_block=TVP; 3: P_block=P_block(-1) + TVP
#_Block_trends: -1: trend bounded by base parm min-max and parms in transformed units (beware); -2: endtrend and infl_year direct values; -3: end and infl as fraction of base range
#_EnvLinks:  1: P(y)=P_base*exp(TVP*env(y));  2: P(y)=P_base+TVP*env(y);  3: P(y)=f(TVP,env_Zscore) w/ logit to stay in min-max;  4: P(y)=2.0/(1.0+exp(-TVP1*env(y) - TVP2))
#_DevLinks:  1: P(y)*=exp(dev(y)*dev_se;  2: P(y)+=dev(y)*dev_se;  3: random walk;  4: zero-reverting random walk with rho;  5: like 4 with logit transform to stay in base min-max
#_DevLinks(more):  21-25 keep last dev for rest of years
#
#_Prior_codes:  0=none; 6=normal; 1=symmetric beta; 2=CASAL's beta; 3=lognormal; 4=lognormal with biascorr; 5=gamma
#
# setup for M, growth, wt-len, maturity, fecundity, (hermaphro), recr_distr, cohort_grow, (movement), (age error), (catch_mult), sex ratio 
#_NATMORT
0 #_natM_type:_0=1Parm; 1=N_breakpoints;_2=Lorenzen;_3=agespecific;_4=agespec_withseasinterpolate;_5=BETA:_Maunder_link_to_maturity;_6=Lorenzen_range
  #_no additional input for selected M option; read 1P per morph
#
1 # GrowthModel: 1=vonBert with L1&L2; 2=Richards with L1&L2; 3=age_specific_K_incr; 4=age_specific_K_decr; 5=age_specific_K_each; 6=NA; 7=NA; 8=growth cessation
0 #_Age(post-settlement)_for_L1;linear growth below this
999 #_Growth_Age_for_L2 (999 to use as Linf)
-999 #_exponential decay for growth above maxage (value should approx initial Z; -999 replicates 3.24; -998 to not allow growth above maxage)
0  #_placeholder for future growth feature
#
0 #_SD_add_to_LAA (set to 0.1 for SS2 V1.x compatibility)
0 #_CV_Growth_Pattern:  0 CV=f(LAA); 1 CV=F(A); 2 SD=F(LAA); 3 SD=F(A); 4 logSD=F(A)
#
1 #_maturity_option:  1=length logistic; 2=age logistic; 3=read age-maturity matrix by growth_pattern; 4=read age-fecundity; 5=disabled; 6=read length-maturity
1 #_First_Mature_Age
1 #_fecundity_at_length option:(1)eggs=Wt*(a+b*Wt);(2)eggs=a*L^b;(3)eggs=a*Wt^b; (4)eggs=a+b*L; (5)eggs=a+b*W
0 #_hermaphroditism option:  0=none; 1=female-to-male age-specific fxn; -1=male-to-female age-specific fxn
1 #_parameter_offset_approach for M, G, CV_G:  1- direct, no offset**; 2- male=fem_parm*exp(male_parm); 3: male=female*exp(parm) then old=young*exp(parm)
#_** in option 1, any male parameter with value = 0.0 and phase <0 is set equal to female parameter
#
#_growth_parms
#_ LO HI INIT PRIOR PR_SD PR_type PHASE env_var&link dev_link dev_minyr dev_maxyr dev_PH Block Block_Fxn
# Sex: 1  BioPattern: 1  NatMort
 0 2 0.135 0 0 0 -3 0 0 0 0 0 0 0 # NatM_uniform_Fem_GP_1
# Sex: 1  BioPattern: 1  Growth
 1 60 6 0 0 0 -4 0 0 0 0 0 0 0 # L_at_Amin_Fem_GP_1
 50 100 67.5 0 0 0 -4 0 0 0 0 0 0 0 # L_at_Amax_Fem_GP_1
 0.05 0.5 0.242 0 0 0 -3 0 0 0 0 0 0 0 # VonBert_K_Fem_GP_1
 0.05 0.25 0.085 0 0 0 -3 0 0 0 0 0 0 0 # CV_young_Fem_GP_1
 0.05 0.25 0.085 0 0 0 -3 0 0 0 0 0 0 0 # CV_old_Fem_GP_1
# Sex: 1  BioPattern: 1  WtLen
 -1 3 1.75e-05 0 0 0 -3 0 0 0 0 0 0 0 # Wtlen_1_Fem_GP_1
 -1 4 2.99 0 0 0 -3 0 0 0 0 0 0 0 # Wtlen_2_Fem_GP_1
# Sex: 1  BioPattern: 1  Maturity&Fecundity
 35 60 40.7 0 0 0 -3 0 0 0 0 0 0 0 # Mat50%_Fem_GP_1
 -4 3 -2.26 0 0 0 -3 0 0 0 0 0 0 0 # Mat_slope_Fem_GP_1
 -3 3 1 0 0 0 -3 0 0 0 0 0 0 0 # Eggs/kg_inter_Fem_GP_1
 -3 3 0 0 0 0 -3 0 0 0 0 0 0 0 # Eggs/kg_slope_wt_Fem_GP_1
# Hermaphroditism
#  Recruitment Distribution 
#  Cohort growth dev base
 0.1 10 1 1 1 0 -1 0 0 0 0 0 0 0 # CohortGrowDev
#  Movement
#  Age Error from parameters
#  catch multiplier
#  fraction female, by GP
 1e-06 0.99999 0.5 0.5 0.5 0 -99 0 0 0 0 0 0 0 # FracFemale_GP_1
#  M2 parameter for each predator fleet
#
#_no timevary MG parameters
#
#_seasonal_effects_on_biology_parms
 0 0 0 0 0 0 0 0 0 0 #_femwtlen1,femwtlen2,mat1,mat2,fec1,fec2,Malewtlen1,malewtlen2,L1,K
#_ LO HI INIT PRIOR PR_SD PR_type PHASE
#_Cond -2 2 0 0 -1 99 -2 #_placeholder when no seasonal MG parameters
#
3 #_Spawner-Recruitment; Options: 1=NA; 2=Ricker; 3=std_B-H; 4=SCAA; 5=Hockey; 6=B-H_flattop; 7=survival_3Parm; 8=Shepherd_3Parm; 9=RickerPower_3parm
0  # 0/1 to use steepness in initial equ recruitment calculation
0  #  future feature:  0/1 to make realized sigmaR a function of SR curvature
#_          LO            HI          INIT         PRIOR         PR_SD       PR_type      PHASE    env-var    use_dev   dev_mnyr   dev_mxyr     dev_PH      Block    Blk_Fxn #  parm_name
             3             7       5.59771             0             0             0          1          0          0          0          0          0          0          0 # SR_LN(R0)
           0.2             1          0.76             0             0             0         -2          0          0          0          0          0          0          0 # SR_BH_steep
             0             2          0.52             0             0             0         -4          0          0          0          0          0          0          0 # SR_sigmaR
            -5             5             0             0             0             0         -4          0          0          0          0          0          0          0 # SR_regime
             0             0             0             0             0             0        -99          0          0          0          0          0          0          0 # SR_autocorr
#_no timevary SR parameters
1 #do_recdev:  0=none; 1=devvector (R=F(SSB)+dev); 2=deviations (R=F(SSB)+dev); 3=deviations (R=R0*dev; dev2=R-f(SSB)); 4=like 3 with sum(dev2) adding penalty
1950 # first year of main recr_devs; early devs can preceed this era
2023 # last year of main recr_devs; forecast devs start in following year
2 #_recdev phase 
1 # (0/1) to read 13 advanced options
 0 #_recdev_early_start (0=none; neg value makes relative to recdev_start)
 -4 #_recdev_early_phase
 0 #_forecast_recruitment phase (incl. late recr) (0 value resets to maxphase+1)
 1 #_lambda for Fcast_recr_like occurring before endyr+1
 1914.3 #_last_yr_nobias_adj_in_MPD; begin of ramp
 1983 #_first_yr_fullbias_adj_in_MPD; begin of plateau
 2021.8 #_last_yr_fullbias_adj_in_MPD
 2023.6 #_end_yr_for_ramp_in_MPD (can be in forecast to shape ramp, but SS3 sets bias_adj to 0.0 for fcast yrs)
 0.8984 #_max_bias_adj_in_MPD (typical ~0.8; -3 sets all years to 0.0; -2 sets all non-forecast yrs w/ estimated recdevs to 1.0; -1 sets biasadj=1.0 for all yrs w/ recdevs)
 0 #_period of cycles in recruitment (N parms read below)
 -5 #min rec_dev
 5 #max rec_dev
 0 #_read_recdevs
#_end of advanced SR options
#
#_placeholder for full parameter lines for recruitment cycles
# read specified recr devs
#_Yr Input_value
#
# all recruitment deviations
#  1950R 1951R 1952R 1953R 1954R 1955R 1956R 1957R 1958R 1959R 1960R 1961R 1962R 1963R 1964R 1965R 1966R 1967R 1968R 1969R 1970R 1971R 1972R 1973R 1974R 1975R 1976R 1977R 1978R 1979R 1980R 1981R 1982R 1983R 1984R 1985R 1986R 1987R 1988R 1989R 1990R 1991R 1992R 1993R 1994R 1995R 1996R 1997R 1998R 1999R 2000R 2001R 2002R 2003R 2004R 2005R 2006R 2007R 2008R 2009R 2010R 2011R 2012R 2013R 2014R 2015R 2016R 2017R 2018R 2019R 2020R 2021R 2022R 2023R
#  0.0816922 -0.243936 0.0345325 -0.0438699 0.176518 0.419152 0.346519 0.240371 -0.0826676 0.648502 -0.0354796 0.142366 0.2837 -0.226366 -0.163164 0.186211 -0.0394876 0.422258 0.162207 -0.151756 -0.425752 -0.256043 0.203607 -0.111035 0.0755117 0.0968115 0.16083 -0.105724 0.176975 0.148799 -0.222731 0.252129 0.0307417 0.508442 0.378171 0.318961 0.0887905 -0.282764 -0.21693 -0.022991 -0.0541628 0.10049 0.0737765 0.109062 -0.281717 0.0299573 -0.303714 -0.158937 -0.382653 -0.757304 -0.220913 -0.240483 0.0570598 -0.354599 -0.11439 -0.36556 -0.13272 0.0356688 -0.0548265 0.0845967 -0.110858 0.108778 -0.133995 0.157228 0.172073 -0.249154 -0.212641 -0.071789 -0.193521 0.212555 0.00271931 0.12263 0.286708 -0.112468#
#Fishing Mortality info 
0.3 # F ballpark value in units of annual_F
-2000 # F ballpark year (neg value to disable)
3 # F_Method:  1=Pope midseason rate; 2=F as parameter; 3=F as hybrid; 4=fleet-specific parm/hybrid (#4 is superset of #2 and #3 and is recommended)
2.9 # max F (methods 2-4) or harvest fraction (method 1)
4  # N iterations for tuning in hybrid mode; recommend 3 (faster) to 5 (more precise if many fleets)
#
#_initial_F_parms; for each fleet x season that has init_catch; nest season in fleet; count = 1
#_for unconstrained init_F, use an arbitrary initial catch and set lambda=0 for its logL
#_ LO HI INIT PRIOR PR_SD  PR_type  PHASE
 0 0.2 0.0126665 0 0 0 1 # InitF_seas_1_flt_1FRS
#
# F rates by fleet x season
# Yr:  1949 1950 1951 1952 1953 1954 1955 1956 1957 1958 1959 1960 1961 1962 1963 1964 1965 1966 1967 1968 1969 1970 1971 1972 1973 1974 1975 1976 1977 1978 1979 1980 1981 1982 1983 1984 1985 1986 1987 1988 1989 1990 1991 1992 1993 1994 1995 1996 1997 1998 1999 2000 2001 2002 2003 2004 2005 2006 2007 2008 2009 2010 2011 2012 2013 2014 2015 2016 2017 2018 2019 2020 2021 2022 2023
# seas:  1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1
# FRS 0.0127933 0.013269 0.0148773 0.0145524 0.0125787 0.013126 0.0105577 0.0138691 0.0198498 0.0124304 0.0102324 0.00911095 0.00711016 0.00926383 0.0112075 0.0111617 0.0125009 0.00873 0.0151088 0.0107816 0.0109876 0.00883394 0.00744182 0.0150701 0.0123596 0.0185855 0.0163986 0.0152053 0.0155267 0.0229457 0.0221091 0.0234162 0.0313559 0.0291136 0.0394897 0.0279892 0.0352708 0.0309102 0.0460395 0.0556793 0.0611179 0.0445218 0.0299772 0.0386702 0.0306066 0.0399283 0.0441419 0.0331355 0.0386908 0.0367251 0.0258471 0.0424224 0.03317 0.0298172 0.0365967 0.0252446 0.0291466 0.020858 0.0248017 0.0255778 0.0351888 0.027367 0.0381848 0.0263973 0.0233074 0.0381888 0.0366286 0.0319233 0.0306759 0.0268246 0.0154979 0.0138463 0.011851 0.0164547 0.0192131
# Non_comm 0.0239101 0.0248344 0.0278314 0.0272425 0.0235441 0.0244993 0.0197348 0.0259523 0.0373274 0.0235344 0.0193951 0.0172048 0.0133814 0.0175512 0.0210891 0.0209637 0.0234803 0.016301 0.0281684 0.020169 0.0205792 0.0166475 0.013997 0.0281677 0.0229764 0.0345834 0.0249905 0.0231748 0.0237156 0.0351233 0.0338843 0.0358192 0.0481248 0.0447113 0.0604795 0.0430929 0.0544268 0.0481631 0.0718379 0.0867154 0.0946305 0.0684319 0.0460285 0.0595816 0.047278 0.0619211 0.0686043 0.0514904 0.0597905 0.0568202 0.0397728 0.0653578 0.0509592 0.0454728 0.0562174 0.0275791 0.0319642 0.0227652 0.027068 0.0278198 0.0383685 0.0299779 0.0418613 0.0289795 0.0255218 0.0418492 0.0400386 0.0350453 0.0336875 0.0292211 0.0168233 0.0150294 0.0128622 0.0179528 0.0209379
#
#_Q_setup for fleets with cpue or survey data
#_1:  fleet number
#_2:  link type: (1=simple q, 1 parm; 2=mirror simple q, 1 mirrored parm; 3=q and power, 2 parm; 4=mirror with offset, 2 parm)
#_3:  extra input for link, i.e. mirror fleet# or dev index number
#_4:  0/1 to select extra sd parameter
#_5:  0/1 for biasadj or not
#_6:  0/1 to float
#_   fleet      link link_info  extra_se   biasadj     float  #  fleetname
         1         1         0         1         0         0  #  FRS
         2         1         0         0         0         0  #  BFISH
         4         1         0         0         0         0  #  BFISH_ResFish
-9999 0 0 0 0 0
#
#_Q_parms(if_any);Qunits_are_ln(q)
#_          LO            HI          INIT         PRIOR         PR_SD       PR_type      PHASE    env-var    use_dev   dev_mnyr   dev_mxyr     dev_PH      Block    Blk_Fxn  #  parm_name
            -5             0      -3.75344             0             0             0          1          0          0          0          0          0          0          0  #  LnQ_base_FRS(1)
             0           0.5    0.00237776             0             0             0          1          0          0          0          0          0          0          0  #  Q_extraSD_FRS(1)
           -10             0      -4.49485             0             0             0          1          0          0          0          0          0          0          0  #  LnQ_base_BFISH(2)
           -10             0      -5.90643             0             0             0          1          0          0          0          0          0          0          0  #  LnQ_base_BFISH_ResFish(4)
#_no timevary Q parameters
#
#_size_selex_patterns
#Pattern:_0;  parm=0; selex=1.0 for all sizes
#Pattern:_1;  parm=2; logistic; with 95% width specification
#Pattern:_5;  parm=2; mirror another size selex; PARMS pick the min-max bin to mirror
#Pattern:_11; parm=2; selex=1.0  for specified min-max population length bin range
#Pattern:_15; parm=0; mirror another age or length selex
#Pattern:_6;  parm=2+special; non-parm len selex
#Pattern:_43; parm=2+special+2;  like 6, with 2 additional param for scaling (average over bin range)
#Pattern:_8;  parm=8; double_logistic with smooth transitions and constant above Linf option
#Pattern:_9;  parm=6; simple 4-parm double logistic with starting length; parm 5 is first length; parm 6=1 does desc as offset
#Pattern:_21; parm=2+special; non-parm len selex, read as pairs of size, then selex
#Pattern:_22; parm=4; double_normal as in CASAL
#Pattern:_23; parm=6; double_normal where final value is directly equal to sp(6) so can be >1.0
#Pattern:_24; parm=6; double_normal with sel(minL) and sel(maxL), using joiners
#Pattern:_2;  parm=6; double_normal with sel(minL) and sel(maxL), using joiners, back compatibile version of 24 with 3.30.18 and older
#Pattern:_25; parm=3; exponential-logistic in length
#Pattern:_27; parm=special+3; cubic spline in length; parm1==1 resets knots; parm1==2 resets all 
#Pattern:_42; parm=special+3+2; cubic spline; like 27, with 2 additional param for scaling (average over bin range)
#_discard_options:_0=none;_1=define_retention;_2=retention&mortality;_3=all_discarded_dead;_4=define_dome-shaped_retention
#_Pattern Discard Male Special
 1 0 0 0 # 1 FRS
 1 0 0 0 # 2 BFISH
 1 0 0 0 # 3 Non_comm
 24 0 0 0 # 4 BFISH_ResFish
#
#_age_selex_patterns
#Pattern:_0; parm=0; selex=1.0 for ages 0 to maxage
#Pattern:_10; parm=0; selex=1.0 for ages 1 to maxage
#Pattern:_11; parm=2; selex=1.0  for specified min-max age
#Pattern:_12; parm=2; age logistic
#Pattern:_13; parm=8; age double logistic. Recommend using pattern 18 instead.
#Pattern:_14; parm=nages+1; age empirical
#Pattern:_15; parm=0; mirror another age or length selex
#Pattern:_16; parm=2; Coleraine - Gaussian
#Pattern:_17; parm=nages+1; empirical as random walk  N parameters to read can be overridden by setting special to non-zero
#Pattern:_41; parm=2+nages+1; // like 17, with 2 additional param for scaling (average over bin range)
#Pattern:_18; parm=8; double logistic - smooth transition
#Pattern:_19; parm=6; simple 4-parm double logistic with starting age
#Pattern:_20; parm=6; double_normal,using joiners
#Pattern:_26; parm=3; exponential-logistic in age
#Pattern:_27; parm=3+special; cubic spline in age; parm1==1 resets knots; parm1==2 resets all 
#Pattern:_42; parm=2+special+3; // cubic spline; with 2 additional param for scaling (average over bin range)
#Age patterns entered with value >100 create Min_selage from first digit and pattern from remainder
#_Pattern Discard Male Special
 12 0 0 0 # 1 FRS
 12 0 0 0 # 2 BFISH
 12 0 0 0 # 3 Non_comm
 12 0 0 0 # 4 BFISH_ResFish
#
#_          LO            HI          INIT         PRIOR         PR_SD       PR_type      PHASE    env-var    use_dev   dev_mnyr   dev_mxyr     dev_PH      Block    Blk_Fxn  #  parm_name
# 1   FRS LenSelex
            25            50       36.4001             0             0             0          2          0          0          0          0          0          0          0  #  Size_inflection_FRS(1)
           0.1            20       4.00917             0             0             0          2          0          0          0          0          0          0          0  #  Size_95%width_FRS(1)
# 2   BFISH LenSelex
             0            50       6.59048             0             0             0          2          0          0          0          0          0          0          0  #  Size_inflection_BFISH(2)
           0.1            50       2.02267             0             0             0          2          0          0          0          0          0          0          0  #  Size_95%width_BFISH(2)
# 3   Non_comm LenSelex
             0            60            40             0             0             0         -2          0          0          0          0          0          0          0  #  Size_inflection_Non_comm(3)
             0            40            11             0             0             0         -2          0          0          0          0          0          0          0  #  Size_95%width_Non_comm(3)
# 4   BFISH_ResFish LenSelex
            10            50       39.6551            36             5             0          2          0          0          0          0          0          0          0  #  Size_DblN_peak_BFISH_ResFish(4)
            -7             7      -1.05702          -0.5             2             0         -3          0          0          0          0          0          0          0  #  Size_DblN_top_logit_BFISH_ResFish(4)
            -5            10     -0.338084          1.75             5             0         -3          0          0          0          0          0          0          0  #  Size_DblN_ascend_se_BFISH_ResFish(4)
            -5            10      -4.82251           0.1             2             0          4          0          0          0          0          0          0          0  #  Size_DblN_descend_se_BFISH_ResFish(4)
          -999            15          -999            -1             5             0        -99          0          0          0          0          0          0          0  #  Size_DblN_start_logit_BFISH_ResFish(4)
          -999            15      -492.002             1             5             0          4          0          0          0          0          0          0          0  #  Size_DblN_end_logit_BFISH_ResFish(4)
# 1   FRS AgeSelex
             0            40             2             5            99             0          2          0          0          0          0          0          0          0  #  minage@sel=1_FISHERY(1)
            -5            50             3             6            99             0          2          0          0          0          0          0          0          0  #  maxage@sel=1_FISHERY(1)
# 2   BFISH AgeSelex
             0            40             1             5            99             0        -99          0          0          0          0          0          0          0  #  minage@sel=1_FISHERY(1)
             0            50             3             6            99             0        -99          0          0          0          0          0          0          0  #  maxage@sel=1_FISHERY(1)
# 3   Non_comm AgeSelex
             0            60             2             5            99             0          2          0          0          0          0          0          0          0  #  minage@sel=1_FISHERY(1)
            -10            60             1             6            99             0          2          0          0          0          0          0          0          0  #  maxage@sel=1_FISHERY(1)
# 4   BFISH_ResFish AgeSelex
             0            10             2             2             5             0          2          0          0          0          0          0          0          0  #  Size_DblN_peak_BFISH_ResFish(4)
           -20            50             1           0.5             2             0          3          0          0          0          0          0          0          0  #  Size_DblN_top_logit_BFISH_ResFish(4)

#_Dirichlet and/or MV Tweedie parameters for composition error
#_multiple_fleets_can_refer_to_same_parm;_but_list_cannot_have_gaps
            -5            10      0.520207             0         1.816             6          2          0          0          0          0          0          0          0  #  ln(DM_theta)_Len_P1
            -5            10   0.000329735             0         1.816             6          2          0          0          0          0          0          0          0  #  ln(DM_theta)_Len_P2
            -5            10      0.198842             0         1.816             6          2          0          0          0          0          0          0          0  #  ln(DM_theta)_Sz_P3

#_no timevary selex parameters
#
0   #  use 2D_AR1 selectivity(0/1)
#_no 2D_AR1 selex offset used
#
# Tag loss and Tag reporting parameters go next
0  # TG_custom:  0=no read and autogen if tag data exist; 1=read
#_Cond -6 6 1 1 2 0.01 -4 0 0 0 0 0 0 0  #_placeholder if no parameters
#
# no timevary parameters
#
#
# Input variance adjustments factors: 
 #_1=add_to_survey_CV
 #_2=add_to_discard_stddev
 #_3=add_to_bodywt_CV
 #_4=mult_by_lencomp_N
 #_5=mult_by_agecomp_N
 #_6=mult_by_size-at-age_N
 #_7=mult_by_generalized_sizecomp
#_Factor  Fleet  Value
      1      1  0.107538
 -9999   1    0  # terminator
#
5 #_maxlambdaphase
1 #_sd_offset; must be 1 if any growthCV, sigmaR, or survey extraSD is an estimated parameter
# read 0 changes to default Lambdas (default value is 1.0)
# Like_comp codes:  1=surv; 2=disc; 3=mnwt; 4=length; 5=age; 6=SizeFreq; 7=sizeage; 8=catch; 9=init_equ_catch; 
# 10=recrdev; 11=parm_prior; 12=parm_dev; 13=CrashPen; 14=Morphcomp; 15=Tag-comp; 16=Tag-negbin; 17=F_ballpark; 18=initEQregime
#like_comp fleet  phase  value  sizefreq_method
-9999  1  1  1  1  #  terminator
#
# lambdas (for info only; columns are phases)
#  1 1 1 1 1 #_CPUE/survey:_1
#  1 1 1 1 1 #_CPUE/survey:_2
#  0 0 0 0 0 #_CPUE/survey:_3
#  1 1 1 1 1 #_CPUE/survey:_4
#  0 0 0 0 0 #_lencomp:_1
#  1 1 1 1 1 #_lencomp:_2
#  0 0 0 0 0 #_lencomp:_3
#  0 0 0 0 0 #_lencomp:_4
#  1 1 1 1 1 #_sizefreq:_1
#  1 1 1 1 1 #_init_equ_catch1
#  1 1 1 1 1 #_init_equ_catch2
#  1 1 1 1 1 #_init_equ_catch3
#  1 1 1 1 1 #_init_equ_catch4
#  1 1 1 1 1 #_recruitments
#  1 1 1 1 1 #_parameter-priors
#  1 1 1 1 1 #_parameter-dev-vectors
#  1 1 1 1 1 #_crashPenLambda
#  0 0 0 0 0 # F_ballpark_lambda
0 # (0/1/2) read specs for more stddev reporting: 0 = skip, 1 = read specs for reporting stdev for selectivity, size, and numbers, 2 = add options for M,Dyn. Bzero, SmryBio
 # 0 2 0 0 # Selectivity: (1) fleet, (2) 1=len/2=age/3=both, (3) year, (4) N selex bins
 # 0 0 # Growth: (1) growth pattern, (2) growth ages
 # 0 0 0 # Numbers-at-age: (1) area(-1 for all), (2) year, (3) N ages
 # -1 # list of bin #'s for selex std (-1 in first bin to self-generate)
 # -1 # list of ages for growth std (-1 in first bin to self-generate)
 # -1 # list of ages for NatAge std (-1 in first bin to self-generate)
999


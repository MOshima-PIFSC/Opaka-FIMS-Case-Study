# File = Convert_Opaka_Length_to_Age.R
# Jon Brodziak, PIFSC, Jon.Brodziak@NOAA,GOV
#
# Purpose: This script converts SS3 length composition data
# for opakpaka to age composition data using an age-length key
# The ALK is based on the growth curve of Andrews et al. (2012)
# with normally distributed process error for length at age

## Clear R environment if needed
## rm(list=ls())

# Set opaka growth parameters for a SS3 parameterization of VB curve
# Length(age) = Linf + (Lmin - Linf)*exp(-k*(age-Amin))
Amin <- 1
Amax <- 45
Lmin <- 18.1001396
Linf <- 67.5
k <- 0.242
CVmin <- 0.12
CVmax <- 0.08

# Set opaka length-weight parameters (cm, kg)
A <- 1.75E-05
B <- 2.99

# Ages are age = [0:Amax] in units of year
# Age bin attributes are: { age, midpoint, upper age, mean length(midpoint)
# and CV of mean length and standard deviation of mean length }
# for the half-open interval [age, upper age)
# Length bin attributes are: (length, midpoint, upper) for the interval [length, upper)]
NAgeAttribute <- 6
NBinAttribute <- 3

# Age settings for opaka
NAgeBin = Amax+1
DimAgeBin <- NAgeBin*NAgeAttribute
AgeBin <- array(rep(0.0,DimAgeBin),c(NAgeBin,NAgeAttribute))
AgeBin[,1] <- seq(0,Amax)
AgeBin[,2] <- AgeBin[,1] + 0.5 
AgeBin[,3] <- AgeBin[,1] + 1
# Set mean length at age
AgeBin[,4] <- Linf + (Lmin-Linf)*exp(-k*(AgeBin[,2]-Amin))
# Set mean length at age for age-0 < Amin=1 by linear interpolation
AgeBin[1,4] <- Lmin*AgeBin[1,2]
# Set CV of mean length at age
AgeBin[1:Amin,5] <- CVmin
AgeBin[NAgeBin,5] <- CVmax
AgeBin[(Amin+1):NAgeBin,5] <- (CVmin*(Amax-AgeBin[(Amin+1):NAgeBin,1])+CVmax*(AgeBin[(Amin+1):NAgeBin,1]-Amin))/(Amax-Amin)
# Calculate the standard deviation of mean length at age
AgeBin[,6] <- AgeBin[,4]*AgeBin[,5]

# Length settings for opaka
NLengthBin <- 17
DimLengthBin <- NLengthBin*NBinAttribute
LengthBin <- array(rep(0.0,DimLengthBin),c(NLengthBin,NBinAttribute))
# Set observed length data bin sizes to be 5 cm starting at 5 cm
LengthBin[,1] <- seq(5,85,5)
# Set upper bound from 10 to 90 cm
LengthBin[,3] <- seq(10,90,5)
# Set midpoint from 7.5 to 87.5 5 cm
LengthBin[,2] <- seq(7.5,87.5,5)

# Compute relative frequencies of length and age bins from 
# normal distributions for mean length at age
DimALK <- NLengthBin*NAgeBin
FrequencyLengthAge <- array(rep(0.0,DimALK),c(NLengthBin,NAgeBin))
for (length in 1:NLengthBin)
{
  FrequencyLengthAge[length,] <- pnorm(LengthBin[length,3],AgeBin[,4],AgeBin[,6])-pnorm(LengthBin[length,1],AgeBin[,4],AgeBin[,6])
}

# Compute conditional probability of age at length
AgeLengthKey <- array(rep(0.0,DimALK),c(NLengthBin,NAgeBin))
for (length in 1:NLengthBin)
{
  AgeLengthKey[length,] <- FrequencyLengthAge[length,]/max(sum(FrequencyLengthAge[length,]),1.0e-10) 
}

# Read SS3 length frequency data from Opaka_len_data.csv
Opaka_len_data <- read.csv("Opaka_len_data.csv",header=TRUE)
LengthComposition <- as.matrix(Opaka_len_data[,7:23])
NSample <- length(LengthComposition[,1])

# Calculate age composition data
DimAgeComposition <- NSample*NAgeBin
AgeComposition <- array(rep(0.0,DimAgeComposition),c(NSample,NAgeBin))
AgeComposition <- LengthComposition%*%AgeLengthKey

# Output Opaka Age Composition Data
NSampleColumn <- 6
NAgeDataColumn <- NAgeBin + NSampleColumn
DimAgeCompositionData <- NSample*NAgeDataColumn
AgeCompositionData <- array(rep(0.0,DimAgeCompositionData),c(NSample,NAgeDataColumn))
colnames(AgeCompositionData) <- c(colnames(Opaka_len_data[1:NSampleColumn]),paste0("Age-",seq(0,Amax,1)))
AgeCompositionData[1:NSample,(NSampleColumn+1):NAgeDataColumn] <- AgeComposition
AgeCompositionData[1:NSample,1:NSampleColumn] <- as.matrix(Opaka_len_data[1:NSample,1:NSampleColumn])
write.csv(AgeCompositionData, file = "Prelim_Opaka_age_data.csv", row.names = FALSE)

# Le Fin: Sans Souci



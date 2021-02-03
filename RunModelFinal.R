
library(lubridate)
dat = read.csv("CropParametersFinal.csv")
path = "C:/Users/jninanya/OneDrive - CGIAR/Desktop/Taller - CIP_LAC/SolanumR/MeteorologicalData/"
FileName = paste0(path, "RCP85Data_2091-2100.csv")

yyy = c(2091:2100)
mtx1 = matrix(nrow = length(yyy), ncol = 4)
mtx2 = matrix(nrow = length(yyy), ncol = 4)
mtx3 = matrix(nrow = length(yyy), ncol = 4)

mtx3 = as.data.frame(mtx3)

for(ik in 1:4){
  
  dfr = dat[ik, ]
  
  for(ij in 1:length(yyy)){
    
    sowing = as.character(paste0(yyy[ij], substr(dfr$sowing, 5, 10)))
    harvest = as.character(as.Date(sowing) + dfr$harvest)
    
    EDay = dfr$Eday 
    plantDensity = dfr$p_density 
    
    wmax = dfr$wmax   
    tm = dfr$tm      
    te = dfr$te     
    
    A_0 = dfr$A 
    Tu_0 = dfr$tu   
    b = dfr$b  
    
    DMcont = dfr$dmc 
    RUE = dfr$rue
    
    Tb_0 = 4          
    To_0 = 15         
    Tu_1 = 28         
    
    Pc = 12           
    w = 0.5           
    
    filename = FileName
    
    source("Module_PotentialGrowth_V2.0.R")
    
     mtx1[ij, ik] = fty[dfr$harvest + 1]
     mtx2[ij, ik] = sum(climate$Rad)
     mtx3[ij, ik] = as.character(climate$Date[1])
  }
  
}

mtx = data.frame(mtx1)

colnames(mtx) = dat$Variety
rownames(mtx) = yyy

write.csv(mtx, "output_RCP85Data_2091-2100.csv")


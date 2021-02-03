


#--------------------#
# SOLANUM RunModel.R #
#--------------------#

x1 = c(0.18, 0.19, 0.20, 0.21, 0.22)
x2 = c(0.60, 0.62, 0.64, 0.66, 0.68, 0.70, 0.72, 0.74, 0.76, 0.78, 0.80)
x3 = c(1.8, 2.0, 2.2, 2.4, 2.6, 2.8, 3.0, 3.2, 3.4, 3.6)

r1 = rep(x3, length(x1)*length(x2))
r2 = rep(x2, each = length(x3), length(x1))
r3 = rep(x1, each = length(x3)*length(x2))

par = data.frame(r1, r2, r3)

n = length(x1)*length(x2)*length(x3)
# = 3

mtx = matrix(nrow = n, ncol = 8)

for(j in 1:n){
  
  filename = "ClimaticDataToCalibration.csv"
  
  # definimos periodo de simulacion
  xfile = read.csv("CropParameters.csv")
  
  dfr = xfile[xfile$Variety == "PucaShunga",]
  
  sowing = as.character(as.Date(dfr$sowing))
  harvest = as.character(as.Date(dfr$sowing) + dfr$harvest)
  
  EDay = dfr$Eday 
  plantDensity = dfr$p_density 
  
  wmax = dfr$wmax   
  tm = dfr$tm      
  te = dfr$te     
  
  Tu_0 = dfr$tu   
  b = dfr$b       
  
  Tb_0 = 4          
  To_0 = 15         
  Tu_1 = 28         
  
  Pc = 12           
  w = 0.5           
  
  obs = dfr$yield_obs

  DMcont = par$r3[j]   
  A_0 = par$r2[j]  
  RUE = par$r1[j]
  
  source("Module_PotentialGrowth_V2.0.R")
  
  mtx[j, 1] = j
  mtx[j, 2] = DMcont
  mtx[j, 3] = A_0
  mtx[j, 4] = RUE
  mtx[j, 5] = obs
  mtx[j, 6] = fty[length(fty)]
  mtx[j, 7] = abs(obs - fty[length(fty)])
  mtx[j, 8] = dty[length(dty)]
    
}


mtx = as.data.frame(mtx)

colnames(mtx) = c("id", "dmc", "A", "RUE", "obs", "fty", "error", "dty")


write.csv(mtx, "out_PucaShunga.csv")







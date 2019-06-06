#SimpleGrowthChooser.r
# This program allow you to simulate a 
# very simple growth process, with you providing a discrete
# list of lambda values and probabilities that each will occur

graphics.off()# closes fig window
rm(list=ls())  # clear all variables

# -----INPUT PARAMETERS----------------------
lams = c(0.4,1.5,0.3,4.8,0.5,4.1,1.6,1.1,0.9,0.8,0.7,3.4,1.2,0.1,2.3,4.4,0.2,1.3,2.5,0.8) # list of lambdas that can occur

maxyr = 500 # the number of years to simulate

startN = 151 # starting population size

Reps = 1000 # number of replicate runs to make		

Nqe = 50 # quasi-extinction threshold
#---- END OF INPUTS ---------------------------

Ns = matrix(0,maxyr,Reps) # set up a matrix for the pop sizes to fill


for (jj in 1:Reps) {
  Ns[1,jj]=startN # initialize with starting pop size
	for (ii in 1:(maxyr-1)) {
		lam_t=sample(lams,1) # choose a random lambda value
	
    
		Ns[(ii+1),jj]=Ns[ii,jj]*lam_t # this grows the population one year
    
    #enforcing the quasi-extinction threshold:
    if (Ns[(ii+1),jj] <= Nqe) {Ns[(ii+1),jj]=0} 
    
	} # end of ii loop
} # end of jj loop


#preparing a matrix to use in estimating extinction risk:
Ns2=Ns 
Ns2[Ns2 >0] = 1 #set all values of Ns that are greater than one to 
alive = apply(Ns2,1,sum)
dead = 100*(1-alive/Reps)


allyrs = c(1:maxyr)
windows()

plot(allyrs,dead,type = "l",xlab="Year",ylab="Extinction CDF")

windows()
matplot(allyrs,Ns, type = "l",xlab="Year",ylab="Nt",main="Arithmetic scale")

windows()
matplot(allyrs,log(Ns), type = "l",xlab="Year",ylab="log(Nt)",main="Log scale")
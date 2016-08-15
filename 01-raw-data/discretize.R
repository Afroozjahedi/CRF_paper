
## This function gets a vector "x" as an input and generates its descretized vector.
## The length of each discret cluster is "step".
## The discret value in each cluster is the Median there.
## If "step" is even, the median will be the average of the middle elements.

discretize <- function( x, step ) {
  h = length(x)   				## Find the size of x
  hh = floor(length(x)/step)*step		## Find the number of steps
  d = data.frame( x, index = 1:h )		## Make an index column
  d = d[order(d$x),]				## Sort x
  ##
  ## Discretize x by the median in each group 
  for ( i in seq(from=1, to=hh, by=step) ) {
        ##
	  ## Find the median in the current group
        med_index1 = i + floor((step-1)/2) 
        med_index2 = i + ceiling((step-1)/2)
        med = ( d$x[med_index1] + d$x[med_index2] )/ 2
        ##
	  ## Replace the group elements with the median
	  for ( j in i:(i+step-1) ) {
		d$x[j] = med			
	  }
  }
  d=d[order(d$index),]				## Put x back to its original order
  return(d$x)					## Return the discretized vector for x
}
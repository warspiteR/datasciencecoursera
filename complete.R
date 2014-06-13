complete <- function(directory, id = 1:332) {
  ## 'directory' is a character vector of length 1 indicating
  ## the location of the CSV files
  
  ## 'id' is an integer vector indicating the monitor ID numbers
  ## to be used
  
  ## Return a data frame of the form:
  ## id nobs
  ## 1  117
  ## 2  1041
  ## ...
  ## where 'id' is the monitor ID number and 'nobs' is the
  ## number of complete cases
  
  ## create empty numeric vector
  nobs<-numeric()
  
  for(i in id)
  {
    
    #construct the filepath
    file_name <- sprintf("%03d.csv", i)
    file_path <- paste(directory,"/",file_name, sep="")
    #read the csv
    data<-read.csv(file_path)
    
    ## get count of all complete cases for given i and add to the numeric vector
    nobs<-c(nobs,sum(complete.cases(data)))
    
  }
  
  #merge the 2 vectors into a new data frame for output
  data.frame(id=id, nobs=nobs)
  
}
  
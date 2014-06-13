corr <- function(directory, threshold = 0) {
  ## 'directory' is a character vector of length 1 indicating
  ## the location of the CSV files
  
  ## 'threshold' is a numeric vector of length 1 indicating the
  ## number of completely observed observations (on all
  ## variables) required to compute the correlation between
  ## nitrate and sulfate; the default is 0
  
  ## Return a numeric vector of correlations
  
  ##get list of files from dir
  files <- list.files( path = directory )
  
  corralationData <- c()
  
  for (i in 1:length(files)){
    
    file_path <- paste(directory,"/",files[i], sep="")
  
    data<-read.csv(file_path)
    
    complete<-data[complete.cases(data),]
    
    ##check against threshold
    if (nrow(complete) > threshold) {
      ##perform the calculation and add to the result
      corralationData <- c(corralationData,cor(complete$sulfate, complete$nitrate))
    }
    
  }
  return (corralationData)
}
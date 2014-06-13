pollutantmean <- function(directory, pollutant, id = 1:332) {
  ## 'directory' is a character vector of length 1 indicating
  ## the location of the CSV files
  
  ## 'pollutant' is a character vector of length 1 indicating
  ## the name of the pollutant for which we will calculate the
  ## mean; either "sulfate" or "nitrate".
  
  ## 'id' is an integer vector indicating the monitor ID numbers
  ## to be used
  
  ## Return the mean of the pollutant across all monitors list
  ## in the 'id' vector (ignoring NA values)

  ##create qualified filename, 3 digits followed with .csv
  file_names <- sprintf("%03d.csv", id)
  
  ##create full file paths
  file_paths <- (paste(directory, file_names, sep="/"))
  
  #read the files, get back a list with data frames
  list_pollutants <- lapply(file_paths, read.csv, header = TRUE)
  
  #combine the objects within the list
  list_pollutants = do.call(rbind.data.frame,list_pollutants)
 
  #get the mean
  polmean <- mean(list_pollutants[[pollutant]], na.rm = TRUE)
 
  #output
  polmean
  
}
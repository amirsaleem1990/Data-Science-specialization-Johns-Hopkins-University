pollutantmean <- function(directory, pollutant, id = 1:332){
	## 'directory' is a character vector of length 1 indicating the location of the csv file
	## 'pollutant' is a character vector of length 1 indicating the name of the pollutant of which we will calculate the mean; eithter 'sulfate' or 'nitrate'
	## 'id' is an integer vectro indicating the monitor ID numbers to be used
	## Return the mean of the pollutant across all monitors list in the 'id' vector (ignoring NA values)
	
	## NOTE: do not round the result!
}


if (pollutantmean("specdata", "nitrate", 70:72) == 1.706047){
	print("OK")
}else print("NO")

if (pollutantmean("specdata", "nitrate", 23)) == 1.280833{
	print("OK")
}else print("NO")
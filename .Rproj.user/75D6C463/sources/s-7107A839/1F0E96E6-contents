###-----------------------------------------------------------------------------
### http://hilaryparker.com/2014/04/29/writing-an-r-package-from-scratch/
###-----------------------------------------------------------------------------

###-----------------------------------------------------------------------------
### First installation
###-----------------------------------------------------------------------------

###----------
### Step 1: Packages you will need
###----------
install.packages("devtools")
install.packages("roxygen2")
library(devtools)
library(roxygen2)

###----------
### Step 2: Create your package directory
###----------
setwd("D:/Drive/Research/Projects/R_Packages/")
create("dacol")

###----------
### Step 3: Add functions
### Copy the following code "TrimOutlier.R" into your R folder.
###----------

#' TrimOutlier Function
#'
#' This function allows you to express your love of cats.
#' @param love Do you love cats? Defaults to TRUE.
#' @keywords outlier
#' @export
#' @examples
#' x = sample(x)
#' TrimOutlier(x)
#'
TrimOutlier = function(x, fraction=0.01)
{
  threshold.low  <- quantile(x, fraction, na.rm = TRUE)
  threshold.high <- quantile(x, 1-fraction, na.rm = TRUE)

  x[x<=threshold.low]  = threshold.low
  x[x>=threshold.high] = threshold.high

  return(x)
}

###----------
### Step 4: Process your documentation
###----------
setwd("./dacol")
#document()
devtools::use_package("tidyverse")
devtools::document()

###----------
### Step 5: Install!
###----------
setwd("..")
devtools::install("dacol")

###----------
### (Bonus) Step 6: Make the package a GitHub repo
### http://kbroman.org/pkg_primer/pages/github.html
#
# 1. Open Git CMD
# 2. Change to the package directory
# 3. Initialize the repository with
#    > git init
# 4. Add and commit everything with
#    > git add .
#    > git commit
# 5. Create a new repository on GitHub website
# 6. Connect your local repository to the GitHub one
#    > git remote add origin https://github.com/ldanai/dacol
# 7. Push everything to github
#    > git push -u origin master
#
###----------


install_github("ldanai/dacol", "ldanai")




###-----------------------------------------------------------------------------
### Load danailib packages
###-----------------------------------------------------------------------------
library(devtools)
library(roxygen2)

setwd("D:/Drive/Research/Projects/R_Packages/dacol")
document()

if(0) install_github("ldanai/dacol", "ldanai")

library(dacol)


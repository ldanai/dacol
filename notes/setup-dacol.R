library(usethis)
library(devtools)
library(pkgdown)
library(rhub)

#-----------------------------------------------------------------------------
# Day-to-day package development
#-----------------------------------------------------------------------------

# [Ctrl + shift + L] Load package you are developing
devtools::load_all()

# [Ctrl + shift + E] Update the documentation, then builds and checks the package
devtools::check()

# [Ctrl + shift + D] Update documents: faster than check()
devtools::document()

# [Ctrl + shift + B] Install and Restart R
# devtools::build()

# [Ctrl + shift + T] Run all test cases
devtools::test()

# [Ctrl + shift + W] Update website
pkgdown::build_site()
# pkgdown::deploy_to_branch()
# pkgdown::deploy_site_github()

#-----------------------------------------------------------------------------
# Setup dacol package
#-----------------------------------------------------------------------------


#-----------------------------------------------------------------------------
# 1. Create a new package
#-----------------------------------------------------------------------------

if(0)
{
  setwd("D:/Work/Research/Projects/201801_R_Packages/")
  usethis::create_package("dacol")
}

if(0)
{
  setwd("D:/Work/Research/Projects/201801_R_Packages/")
  usethis::create_package("dacol")
}

#-----------------------------------------------------------------------------
# 2. Modify the package description
#-----------------------------------------------------------------------------
usethis::use_rstudio()
usethis::use_mit_license("Danai L")

#usethis::use_package("tidyverse")
#usethis::use_package("tidyverse", "Suggests")
usethis::use_package("dplyr")

# Generate manual documents
devtools::document()

devtools::check_win_devel()
#devtools::check_win_release()

#-----------------------------------------------------------------------------
# 3. Set up various packages
#-----------------------------------------------------------------------------
#usethis::use_roxygen_md()

#-----------------------------------------------------------------------------
# 4. Set up other files
#-----------------------------------------------------------------------------

# Set up readme.md for github
usethis::use_readme_md()

# Set up news.md for github
usethis::use_news_md()

## Set up README.md in github
usethis::use_readme_rmd()

# Initial test
usethis::use_test("my-test")
usethis::use_testthat()

# Setup github action CI (initial ./.github/workflow/R-CMD-check.yml)
usethis::use_github_action_check_full()

# Initial (.travis.yml, .appveyor.yml, codecov.yml) to (.Rbuildignore)
# usethis::use_travis()
# usethis::use_appveyor()
# usethis::use_coverage()

usethis::use_tidy_ci()

# Add Code of Conduct
usethis::use_code_of_conduct()

#-----------------------------------------------------------------------------
# Add data attached to the package
#-----------------------------------------------------------------------------
if(0)
{
  dta   = readRDS("../0_data/test_data_dacol.rds")
  model = readRDS("../0_data/test_model_dacol.rds")
}

usethis::use_data(dta, model)
usethis::use_data(dta, model, overwrite = TRUE)

usethis::use_data_raw()

#-----------------------------------------------------------------------------
# Use pkgdown to build the package website
# http://r-pkgs.had.co.nz/git.html
#-----------------------------------------------------------------------------

# Create pkgdown.yml
usethis::use_pkgdown()

# Create vignette
use_vignette("dacol-getstart", title = "dacol guide")
use_article("dacol-guide", title = "dacol guide")
use_article("test-article", title = "Test article")

pkgdown::build_site()

# Setup CI (github actions) for pkgdown website
# Create directory "/.github/workflows/pkgdown.yaml"
usethis::use_github_action("pkgdown")

# Create gh-pages branchs
pkgdown::deploy_to_branch()

# # Switch to branch: gh-pages
# > git checkout --orphan gh-pages
# # Clean all (untracked) files:
# > git reset --hard or git rm -rf .
# # Create first commit:
# > git commit --allow-empty -m "Initializing gh-pages branch"
# > git push origin gh-pages
# > git pull origin gh-pages
# # To synchronise this branch to GitHub from inside RStudio, you will need to first tell Git that your local branch has a remote equivalent:
# > git push --set-upstream origin gh-pages
#
# # http://r-pkgs.had.co.nz/git.html
# # To synchronise this branch to GitHub from inside RStudio, you???ll notice that push and pull are disabled: .
# # you will need to first tell Git that your local branch has a remote equivalent:
# > git push --set-upstream origin <branch-name>
# > git push --set-upstream origin gh-pages
#
# Force merge ([error message] git pull fatal: refusing to merge unrelated histories)
# > git pull origin branchname --allow-unrelated-histories
# > git pull origin master --allow-unrelated-histories



#-----------------------------------------------------------------------------
# Happy Git
# https://happygitwithr.com/rstudio-git-github.html
# https://happygitwithr.com/ssh-keys.html#ssh-keys
#
# To avoid keep asking password
#    - Open Git BACH
#    - Go to the dacol directory in local computer
#    - Enter this:
#      > git config remote.origin.url git@github.com:ldanai/dacol.git
#-----------------------------------------------------------------------------

# Make this dacol to use an active usethis-git project
usethis::use_git()

# show situation report on your git project
usethis::proj_sitrep()

# show situation report on your git status
usethis::git_sitrep()

# Get github token
usethis::github_token()  # Sys.getenv("GITHUB_TOKEN")
#
# Get github pat
usethis::github_pat() # Sys.getenv("GITHUB_PAT")


#-----------------------------------------------------------------------------
# Install package from github
#-----------------------------------------------------------------------------

# Install your package (with dependency packages)
install_github("ldanai/dacol", "ldanai")

# Install your package (without installing dependency packages)
install_github("ldanai/dacol", "ldanai", dep=FALSE)

# Load your package
library(dacol)



#-----------------------------------------------------------------------------
# Iterative steps for package development process
# - write functions
# - Test functions
# - Update changes using git
# - Update package document inside packages
# - Update package document in README.md, NEWS.md
# - update package website
#-----------------------------------------------------------------------------

# [Ctrl + Shft + L] Load package you are developing
devtools::load_all()

# [Ctrl + Shft + E] Update the documentation, then builds and checks the package
devtools::check()
#devtools::check_win_devel()

# [Ctrl + Shft + D] Update documents (faster than check() command)
devtools::document()

# [Ctrl + shift + T] Test the defined test cases
devtools::test()

# [Ctrl + shift + B] Install and Restart R
devtools::build()

# 6. Update website
pkgdown::build_site()

# 7. Git commit (Using Rstudio GUI)

# 8. Upload package to Github (Using Rstudio GUI)


# 9. Release issue
usethis::use_release_issue("0.1")

# 10. Release
if(0) usethis::use_github_release()

# 11. Continue dev version
if(0) usethis::use_dev_version()

# 9. Install package from Github
if(0)
{
  install_github("ldanai/dacol", "ldanai")
  install_github("ldanai/dacol", "ldanai", dep=FALSE)
}

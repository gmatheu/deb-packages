## Scripts to generate handy deb packages

Packages are essentially bash scripts that download, create folder structures, creates links and/or needed files and finally it executes [fpm](%5Bhttps://github.com/jordansissel/fpm) to generate the final [deb package](http://en.wikipedia.org/wiki/Deb_%28file_format%29)




#### Example: Build and install chromedriver
`cd chromedriver`

`./build.sh` generates the deb package

`sudo dpkg -i chromedriver_X.xx_amd64.deb` installs the package in the current system

# MSA Borders for Geospatial Analysis  
---

This repository is meant to help those working on geospatial analysis working with US data. Here we've
provided some simple code to separate Major Statistical Areas (MSAs). With this information, a user can
simply marry their data with the counties or MSAs and apply a color gradient of their choice. The default
code just outlines all MSA in orange for the United States.

# Packages and How to Run
---
We are using R 3.4.3 (Kite-Eating Tree) on a 64-bit system. Below are the packages necessary to
work with our shape files and manipulate our data:

- [xlsx](https://www.google.com/url?sa=t&rct=j&q=&esrc=s&source=web&cd=1&cad=rja&uact=8&ved=0ahUKEwjZlKGK5KPYAhXIhlQKHZXLCvkQFggnMAA&url=https%3A%2F%2Fcran.r-project.org%2Fweb%2Fpackages%2Fxlsx%2Fxlsx.pdf&usg=AOvVaw1849IdtbF2_eFXl9nhk7u4):
Allows users to read and write Microsoft Excel files
- [maptools](https://www.google.com/url?sa=t&rct=j&q=&esrc=s&source=web&cd=1&cad=rja&uact=8&ved=0ahUKEwjysazp5KPYAhXliVQKHZN9D_YQFggnMAA&url=https%3A%2F%2Fcran.r-project.org%2Fweb%2Fpackages%2Fmaptools%2Fmaptools.pdf&usg=AOvVaw24aTP4j_OhPpYDlyvYVdcx):
Efficiently works with and visualizes spatial data
- [rgdal](https://www.google.com/url?sa=t&rct=j&q=&esrc=s&source=web&cd=1&cad=rja&uact=8&ved=0ahUKEwjYqJyC5aPYAhXlhlQKHWjWCPQQFggnMAA&url=https%3A%2F%2Fcran.r-project.org%2Fpackage%3Drgdal%2Frgdal.pdf&usg=AOvVaw1YVdEJxTJAAYs6vyR436-I):
Binds together shapes
- [ggplot2](https://www.google.com/url?sa=t&rct=j&q=&esrc=s&source=web&cd=1&cad=rja&uact=8&ved=0ahUKEwjQ1uCa5aPYAhXji1QKHbkgBvsQFggnMAA&url=http%3A%2F%2Fggplot2.org%2F&usg=AOvVaw3ySKKF6Z1ybYGrpqHbzLjc):
Data visualization for R
- [maps](https://www.google.com/url?sa=t&rct=j&q=&esrc=s&source=web&cd=1&cad=rja&uact=8&ved=0ahUKEwjS9_Kq5aPYAhUnwlQKHQfXBPMQFggnMAA&url=https%3A%2F%2Fcran.r-project.org%2Fweb%2Fpackages%2Fmaps%2Fmaps.pdf&usg=AOvVaw1ldcRRu7cd5GL8qxbgzpSY): 
Draws shapes that can be visualized in [maptools](https://www.google.com/url?sa=t&rct=j&q=&esrc=s&source=web&cd=1&cad=rja&uact=8&ved=0ahUKEwjysazp5KPYAhXliVQKHZN9D_YQFggnMAA&url=https%3A%2F%2Fcran.r-project.org%2Fweb%2Fpackages%2Fmaptools%2Fmaptools.pdf&usg=AOvVaw24aTP4j_OhPpYDlyvYVdcx)
- [scales](https://www.google.com/url?sa=t&rct=j&q=&esrc=s&source=web&cd=1&cad=rja&uact=8&ved=0ahUKEwjoyeDY5aPYAhVmsFQKHdaABfMQFggnMAA&url=https%3A%2F%2Fcran.r-project.org%2Fweb%2Fpackages%2Fscales%2Fscales.pdf&usg=AOvVaw1BJJwNo7Nfh5Bojm9QrLRW):
Handles axis and scaling aesthetics for plots 
- [stringr](https://www.google.com/url?sa=t&rct=j&q=&esrc=s&source=web&cd=1&cad=rja&uact=8&ved=0ahUKEwjj3vHt5aPYAhVLrVQKHSHuB_UQFgg1MAA&url=https%3A%2F%2Fcran.r-project.org%2Fweb%2Fpackages%2Fstringr%2Fvignettes%2Fstringr.html&usg=AOvVaw1btkGaNur9x_7RxwC3upHa):
String manipulation 
- [plyr](https://www.google.com/url?sa=t&rct=j&q=&esrc=s&source=web&cd=3&cad=rja&uact=8&ved=0ahUKEwj9iY-D5qPYAhWqxlQKHfNiA_kQFggyMAI&url=https%3A%2F%2Fcran.r-project.org%2Fweb%2Fpackages%2Fplyr%2Fplyr.pdf&usg=AOvVaw07lkdFmlvgISQgujO-LsHz):
Data manipulation tool that allows users to separate, manipulate, and rebuild 
- [dplyr](https://www.google.com/url?sa=t&rct=j&q=&esrc=s&source=web&cd=3&cad=rja&uact=8&ved=0ahUKEwjIqamY5qPYAhXS-lQKHdTQDvUQFgg9MAI&url=https%3A%2F%2Fcran.r-project.org%2Fweb%2Fpackages%2Fdplyr%2Fdplyr.pdf&usg=AOvVaw1bU2fwsbnBdcmjpAnn4e_l):
 A simplified version of plyr, but relies on the plyr package's installation
 
There are three files necessary to run the code: `key.xlsx`, `msa.xlsx`, and `tl_2016_us_county.shp`. The
first two are included in the repository but the third must be downloaded from [TIGER](https://catalog.data.gov/dataset/tiger-line-shapefile-2016-nation-u-s-current-county-and-equivalent-national-shapefile),
who determines the boundaries of MSAs and publishes the shape files. Once the zip file is downloaded
and the contents are extracted, the user must put `tl_2016_us_county.shp` in the data folder. Lastly, 
to run the code, the user must define their working directory to their local repository (on row 14).

Should all be done correctly above, the code will run and output a grey map of the US with orange shapes
outlining all US MSAs.

# Troubleshooting `library(rJava)`
---
If you're using a Windows operating system to run the script, you might run into issues with `library(xlsx)` not running.
This likely due to the bit system and the Java file path that it dependancy, `rJava`, was expecting. This issue has been addressed
on [StackOverflow](https://stackoverflow.com/questions/26806776/r-project-xlsx-package-installation-failure-due-to-java-issues)
and [R-statistics blog](https://www.r-statistics.com/2012/08/how-to-load-the-rjava-package-after-the-error-java_home-cannot-be-determined-from-the-registry/).
To summarize the two posts, `xlsx` relies on [Java](https://java.com/en/download/) to run properly. If you have a 32-bit version of R, 
`xlsx` is going to look for a 32-bit version of Java, which is typically in `C:\Program Files (x86)` and if you have a 
64-bit version, the expected file path is likely `C:\Program Files\`. Users can see which bit version of R they have when
they first open R where it says `Platform:` (row 3). At the end of the text, it will either say `(32-bit)` or `(64-bit)`.
Depending on the version you have, install the appropriate Java package. After Java has been downloaded, users should run
one of the following depending on their version of R:

- `Sys.setenv(JAVA_HOME='C:\\Program Files\\Java\\NAME OF FOLDER')` for the 64-bit version
- `Sys.setenv(JAVA_HOME='C:\\Program Files (x86)\\Java\\NAME OF FOLDER')` for the 32-bit version

Afterwards, restart R and you should be able to successfully run `install.packages("rJava")` and `library(rJava)`.
If so, users can run the `xlsx` package and continue running the script.
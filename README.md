# Merged Global Pluvial Flood DataBase (MGPF_DB)  

This Python tool merges four (regional and global) flood databases into one single database that contains only global reports for pluvial floods for the period April 2016 - March 2017. 

This tool uses data wrangling methods to ehnhance the usability of each single database to understand the capability of current global rainfall forecasts in predicting pluvial floods (including flash floods). 
  
This repository contains:
1. the Python code that selects and post-processes the pluvial flood reports from four different databases, and merges them into one single global database for pluvial flood reports.
2. a Jupyter notebook that runs the Python code, which can also be deployed using MyBinder.org to create a sharable, interactive, reproducible environment, so that the Jupyter notebook can be used by many remote users.

The four original databases are:
1. FloodList, FL (Global domain): http://floodlist.com/
2. Emergency Events Database, EMDAT (Global domain): https://www.emdat.be/
3. European Severe Weather Database, ESWD (Europe): https://www.essl.org/cms/european-severe-weather-database/
4. Storm Events Database, SED (USA): https://www.ncdc.noaa.gov/stormevents/ 

_NOTE: For more details about these databases (documentation, licenses, etc.), look at the README.md file in the Zenodo repository that contains the raw data used in this repository (badge below)._

__*License*__  
[![License: CC BY-NC-SA 4.0](https://licensebuttons.net/l/by-nc-sa/4.0/80x15.png)](https://creativecommons.org/licenses/by-nc-sa/4.0/)

__*Deploy Jupyter Notebook with MyBinder.org*__     
[![Binder](https://mybinder.org/badge_logo.svg)](https://mybinder.org/v2/gh/FatimaPillosu/Test_JupyterNB_Bynder.git/master)     

__*Data DOI - Zenodo Repository (input databases and MGPF_DB)*__  
[![DOI](https://zenodo.org/badge/DOI/10.5281/zenodo.3479846.svg)](https://doi.org/10.5281/zenodo.3479846)

__*Code DOI - Zenodo Repository (Python code and Jupyter notebook)*__  
[![DOI](https://zenodo.org/badge/DOI/10.5281/zenodo.3479846.svg)](https://doi.org/10.5281/zenodo.3479846)


------------------------------------------

## Getting Started

### Prerequisites

Python 3
Metview-Python

### Installing

There are two ways to run the Jupyter notebook:
1. In the cloud, on a web brower: click on the badge "launch binder".
2. On your local machine: 

```sh
$ git clone https://github.com/FatimaPillosu/Merged-Global-Flash-Flood-DB.git
$ cd Merged-Global-Flash-Flood-DB
$ ./Launch_Jupyter_Matlab.sh
```

## Running the tests

Explain how to run the automated tests for this system

### Break down into end to end tests

Explain what these tests test and wh
```
Give an example
```

### Coding style tests

Explain what these tests test and why

```
Give an example
```

## Versioning

[SemVer](http://semver.org/) is used for versioning. For the versions available, see the [releases](https://github.com/FatimaPillosu/Merged-Global-Flash-Flood-DB/releases) for this repository. 

## Authors

* **Fatima Pillosu** - [FatimaPillosu](https://github.com/FatimaPillosu)


## Acknowledgments

*Thanks to the owners of the raw reports to allow the publication of the data to allow the fully reprocibility of the Matlab toolbox and the Jupiter notebook.



# Merged Global Pluvial Floods DataBase (MGPF_DB)  

<p>&nbsp;</p>  

## Project Overview
This project develops a Python tool that merges four flood databases into a single database that contains global reports only for pluvial floods (including flash floods) for the period April 2016 - March 2017. 

This tool uses data wrangling methods to enhance the usability of each single database to answer the following research question: current global rainfall forecasts can be succesfully used as proxy variables to predict pluvial/flash floods? 
  
<p>&nbsp;</p>

## Repository Content
The Jupyter notebook runs a Python code that post-processes the raw flood reports, using information extracted from other datasets, to select some reports of interest (mainly regarding pluvial and flash floods). At a later stage, such reports are merged into a single database for global pluvial/flash flood reports. The Jupyter notebook also runs a Metview-Python code to visualize partial and final results as map plots.

The Jupyter notebook can be deployed with MyBinder.org (badge below) to create a sharable, interactive, and reproducible environment. Thus, the notebook can be used by remote users to verify the methodology used to create the MGPF_DB or compute the MGPF_DB for another period.

The four original databases are:
1. FloodList, FL (Global domain): http://floodlist.com/
2. Emergency Events Database, EMDAT (Global domain): https://www.emdat.be/
3. European Severe Weather Database, ESWD (Europe): https://www.essl.org/cms/european-severe-weather-database/
4. Storm Events Database, SED (USA): https://www.ncdc.noaa.gov/stormevents/ 

_NOTE: For more details about these databases (documentation, licenses, etc.), look at the README.md file in the Zenodo repository that contains the raw reports (badge below)._

__*License*__  
[![License: CC BY-NC-SA 4.0](https://licensebuttons.net/l/by-nc-sa/4.0/80x15.png)](https://creativecommons.org/licenses/by-nc-sa/4.0/)

__*Deploy Jupyter Notebook with MyBinder.org*__     
[![Binder](https://mybinder.org/badge_logo.svg)](https://mybinder.org/v2/gh/FatimaPillosu/Merged_Global_Pluvial_Floods_DataBase/master)

__*Data DOI - Zenodo Repository (input databases and MGPF_DB)*__  
[![DOI](https://zenodo.org/badge/DOI/10.5281/zenodo.3633750.svg)](https://doi.org/10.5281/zenodo.3633750)

__*Code DOI - Zenodo Repository (Python code and Jupyter notebook)*__  
[![DOI](https://zenodo.org/badge/DOI/10.5281/zenodo.3479846.svg)](https://doi.org/10.5281/zenodo.3479846)


<p>&nbsp;</p>

## Getting Started

### Prerequisites

1. **Anaconda Distribution** (to get _Python3_, _Numpy_, _Pandas_, and _Matplotlib_ to process the flood reports).  
Information about Anaconda Distribution and download can be found [here](https://www.anaconda.com/distribution/).     

2. **Metview-Python** (to plot the flood reports in the database).  
Information about Metview-Python can be found [here](https://confluence.ecmwf.int/display/METV/Metview%27s+Python+Interface).

3. **Zenodo_get** (to download records from Zenodo).  
Information about Zenodo_get can be found [here](https://zenodo.org/record/1261813#.XjWXhOGnw5k).

4. **Google Maps Geolocation API Key** (the Geolocation API converts an address into lat/lon coordinates).
Information on how to get and enable a Google Maps Geolocation API Key can be found [here](https://developers.google.com/maps/gmp-get-started).

### Install the virtual environment to run the Jupyter Notebook

1. **Install Anaconda Distribution**   
Follow the link provided in the "Prerequisites" section at point 1. Note that you must install the Anaconda version that runs Python3 as it is required by Metview-Python. At a later stage, check whether conda has been installed correctly and whether conda is up to date (updating any packages if necessary by typing _"y"_ to proceed).
```sh
$ conda -V
conda 4.7.12
$ conda update conda
```

2. **Download the repository**  
```sh
$ cd # goes to the user's /home
$ git clone https://github.com/FatimaPillosu/Merged_Global_Pluvial_Floods_DataBase.git
```

3. **Create and activate the virtual environment**  
These steps will install all the Python modules and the binaries of Metview-Python needed to run the Jupiter notebook.
```sh
$ cd Merged_Global_Pluvial_Floods_DataBase
$ conda env create -f environment.yml
$ conda activate Metview-Python
```

4. **Run the Jupiter Notebook**
```sh
(Metview-Python): $ jupyter notebook MGPF_DB.ipynb
```

 
<p>&nbsp;</p>

## Versioning  
MGPF_DB uses the [SemVer](http://semver.org/) standard for its versioning. Have a look to the available versions [here](https://github.com/FatimaPillosu/Merged_Global_Pluvial_Floods_DataBase/releases). 

## Authors  
**Fatima Pillosu:** [Github](https://github.com/FatimaPillosu) - [Orcid](https://orcid.org/0000-0001-8127-0990) - [ResearchGate](https://www.researchgate.net/profile/Fatima_Pillosu) - [Twitter](https://twitter.com/pillosufatima?lang=en)

## Acknowledgments  
_Thanks to the owners of the original databases for granting the publication of the raw reports within this repository. This allows the fully reproducibility of the Jupiter notebook_.

# OBJECTIVE

The script performs collection of climate indices related to hydromet hazards.
The spatial information is collected from Copernicus C3S.

The climate component estimates the increase in the disaster risk score over the baseline by evaluating the anomaly (standard deviation) of hazard-related climate indices for the required future time horizon over the reference period.

The output is exported in form of tables, statistics, charts (excel format) and maps (geopackage).


# SCRIPT OVERVIEW

- Script runs on one country at time to keep the calculation time manageable
- - User input is required to define country and settings
- Settings affect how the processing runs (criteria, thesholds)
- All RCP scenarios are considered and presented in the results: RCP 2.6, 4.5, 8.5
- The estimate is provided for median, 10th-percentile and 90th percentile
- The information is aggregated at ADM2 level
- The table results are exported in excel format
- The vector rsults are exported in gpkg format


# SCRIPT STRUCTURE

- SETUP: environment and libraries
- USER INPUT: required
- SETTINGS: default parameters can be changed by user
- DATA MANAGEMENT: global datasets are loaded according to user input
- DATA PROCESSING: datasets are processed according to settings
- PREVIEW RESULTS: plot tables and maps
- EXPORT RESULTS: results are exported as geopackage and csv according to templates

# PRE-REQUISITES (OFFLINE)

- Anaconda and python installed > Possibly we move to jupyter desktop Autoinstaller
- Create environment from ccdr_analytics.yml

# SCRIPT STEP-BY-STEP

## SETUP

- Load required libraries

## USER INPUT

- Hazard of interest: Flood and Landslide, Tropical Cyclone, Coastal flood, Drought and Water Scarcity, Heat
- Country of interest (1): Name or ISO code 
- Time horizon: 2040, 2060, 2080, 2100

## SETTINGS (DEFAULT can be changed)

- Criteria for value aggregation: a) MAX; b) Mean

------------------------------------------

## DATA MANAGEMENT

- Creation of string request based on input (hazard, country and period)
- String links to nc files hosted / downloaded from CCKP

## DATA PROCESSING - PROJECTIONS

- Run zonal statistic using ADM2 as zone and nc data as value based on input (country, horizon, RCP) and settings aggregation criteria

## PREVIEW RESULTS - PROJECTIONS

- Plot indices as map and as tables/charts
  - On ADM2 map selection (mouse click), each indices is plotted as a one line chart that includes:
    -  3 lines of different colors (green, yellow, orange) representing the median for each RCP
    -  3 shade areas representing the related p10 and p90 for each RCP
    -  X is period (as from input)
    -  Y is intensity (depends on index selection)
    -  Title specify aggregation criteria

Similar to common RPC representation:

<img width="500" src="https://user-images.githubusercontent.com/44863827/154677308-610702d4-1312-4ce5-b16c-e2b99e961c1e.png">

## EXPORT RESULTS - PROJECTIONS

- Export output as gpkg and csv

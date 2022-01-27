# OBJECTIVE

The script performs collection of climate indices related to hydromet hazards.
The spatial information is collected from Copernicus C3S.

The climate component estimates the increase in the disaster risk score over the baseline by evaluating the anomaly (standard deviation) of hazard-related climate indices for the required future time horizon over the reference period.

The output is exported in form of tables, statistics, charts (excel format) and maps (geopackage).


# SCRIPT OVERVIEW

- Script runs on one country at time to keep the calculation time manageable.
- - User input is required to define country and settings.
- Settings affect how the processing runs (criteria, thesholds).
- The information is aggregated at ADM2 level
- The table results are exported in excel format.
- The vector rsults are exported in gpkg format.


# SCRIPT STRUCTURE

- SETUP: environment and libraries
- USER INPUT: required
- SETTINGS: default parameters can be changed by user
- DATA MANAGEMENT: global datasets are loaded according to user input
- DATA PROCESSING: datasets are processed according to settings
- PREVIEW RESULTS: plot tables and maps
- EXPORT RESULTS: results are exported as excel according to template

# PRE-REQUISITES (OFFLINE)

- Anaconda and python installed > Possibly we move to jupyter desktop Autoinstaller
- Create environment from ccdr_analytics.yml

# SCRIPT STEP-BY-STEP

## SETUP

- Load required libraries

## USER INPUT

- Country of interest (1): Name or ISO code 
- Time horizon: Historical, 2050, 2080 
- RCP scenario: RCP 2.6, 4.5, 6.5, 8.5 

## SETTINGS (DEFAULTS can be changed)

- Criteria for aggregation: a) MAX; b) Mean
- Min Hazard threshold: data below this threshold are being ignored
- Max Hazard threshod: data above this threshold are considered as the threshold value (max expected impact)

## SUMMARY OUTPUT SETTINGS

- Display input and settings:

	- Country: Nepal (NPL)
	- Exposure: Population
	- Values aggregation criteria: Max


------------------------------------------


## DATA MANAGEMENT

- Load results from Baseline analysis
- Creation of API request based on selected country and scenario options (period, RCP)
- Harvest climate indices information as tables of SD

## DATA PROCESSING - PROJECTIONS

- Apply rule to change risk level based on SD

## PREVIEW RESULTS - PROJECTIONS

- Plot indices tables/charts

## EXPORT RESULTS - PROJECTIONS

- Export tables and charts as excel

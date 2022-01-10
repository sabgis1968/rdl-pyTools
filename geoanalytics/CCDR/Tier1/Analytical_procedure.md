# OBJECTIVE

The script performs combination of hazard and exposure geodata from global datasets according to user input and settings.
Returns output as table and statistics.

# SCRIPT OVERVIEW

Each script is hazard specific, because each hazard has its own metrics and thresholds; putting all in one script could be confusing for the user.
Script runs on one country at time to keep the calculation time manageable.

# SCRIPT STRUCTURE

- SETUP: environment and libraries
- USER INPUT: required
- SETTINGS: default parameters can be changed by user
- DATA MANAGEMENT: global datasets are loaded according to user input
- DATA PROCESSING: datasets are processed according to settings
- RESULTS PREVIEW:
- DATA EXPORT: results are exported as excel according to template


# PROCESSING STEPS

## SETUP

- Load required libraries
- Load HazardStats script (zonal statistics)

## USER INPUT

- Country of interest (1): Name or ISO code 
- Exposure category (1): a) population; b) land cover 


Optional:
- Future time horizon: 2050, 2080 
- RCP scenario: RCP 2.6, 4.5, 6.5, 8.5 

## SETTINGS (DEFAULTS can be changed)

- Criteria for aggregation: a) MAX; b) Mean
- Number of classes: 5 (3 to 10)
- Min Hazard threshold: 
- Max Hazard threshod: 

## DATA MANAGEMENT
- Load population from WorldPop API using ISO3 code:

	https://www.worldpop.org/rest/data/pop/wpgp?iso3=NPL

	returns a Json that includes the url of data:

	https://data.worldpop.org/GIS/Population/Global_2000_2020/2001/NPL/npl_ppp_2001.tif
	

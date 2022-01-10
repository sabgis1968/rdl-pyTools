# OBJECTIVE

The script performs combination of hazard and exposure geodata from global datasets according to user input and settings.
First runs at the grid level, then aggregates the output ad ADM3 boundary level.
Returns output as table and statistics and exports it in excel format and geopackage.

# SCRIPT OVERVIEW

- Each script is hazard specific, because each hazard has its own metrics and thresholds; putting all in one script could be confusing for the user.
- Script runs on one country at time to keep the calculation time manageable.
- The analysis is carried at the resolution of the exposure layer. For prototype, worldpop is 100m.
- User input is required to define country, exposure layer, and settings.
- Settings affect how the processing runs (criteria, thesholds, number of classes).
- The core of the analysis is zonal statistics: how much population falls in each class of hazard.
- The information is aggregated at ADM2 level and combined with Vulnerability scores according to an algo (tbd) to produce impact score for each RP.
- The exceedance frequency curve (EFC) is built and plotted by interpolation of these 3 points.
- The expected annual impact (EAI) is computed by multiplying the impact score with the frequency (1/RP) of the events and sum the multiplied impact.
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


# SCRIPT STEP-BY-STEP

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
- Min Hazard threshold: data below this threshold are being ignored
- Max Hazard threshod: data above this threshold are considered as the threshold value (max expected impact)

## DATA MANAGEMENT

- Load country boundaries from ADM_012.gpkg (world boundaries at 3 levels). Includes ISO3 code related to country name.
	- The whole gpkg is 1.5 Gb, for now I have a SAR-only version loaded. Would be good to have a way to get only the required ISO from main gpkg.

- Load population from WorldPop API according to ISO3 code:

	https://www.worldpop.org/rest/data/pop/wpgp?iso3=NPL

    returns a Json that includes the url of data:

	https://data.worldpop.org/GIS/Population/Global_2000_2020/2001/NPL/npl_ppp_2001.tif
	
    This is a 100m grid representing the total popuation estimated in each cell.

- Load hazard data from drive (for prototype). Most hazard data consist of 3 grids, each representing one event frequency (return period).


## DATA PROCESSING

- For each hazard RP:
  - Apply hazard min and max thresholds and classify hazard values in classes according to settings
  - Perform zonal statistic (SUM) for each hazard class (3 to 10) over exposure grid

- Output table: [RP;hazard_class;population]

- Aggregate at ADM2 level according to criteria (Max or Mean)

- For each ADM2:
  - Calculate impact for each RP (RPx_impact)
  - Calculate EAI from all RP_impact

- Aggregate ADM2 values to ADM1 and ADM0 according to criteria


## PREVIEW RESULTS

- Plot map of ADM2/ADM1/ADM0
- Plot tables/CHarts

## EXPORT RESULTS

- Export tables and charts as excel
- Export ADM2/ADM1/ADM0 with joined values as gpkg

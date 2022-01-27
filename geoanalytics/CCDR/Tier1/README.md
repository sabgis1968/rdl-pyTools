# CCDR ANALYTICAL NOTEBOOKS - TIER 1

## Multi-hazard risk evaluation based on global/regional datasets

Different workflows for different hazard and vulnerability (impact model) types:

BASELINE RISK:
- Analytical_procedure_function.md : impact model based on mathematic function (impact curve)
- Analytical_procedure_classes.md : impact model based on classification (impact categories), when no function is available

FUTURE RISK:
- Analytical_procedure_projections.md : collect climate indices anomalies and evaluate trend

--------------------------------------

## EQUIVALENT PROCESSING IN QGIS

### DATA MANAGEMENT

- Load map data: ADM units (3 layers), hazard (one or as many layers as RP scenarios) and exposure (population map, land cover, etc).
  In this example, we use FATHOM river flood data (light blue) and WorldPop2020-constrained-US_adjusted population data (green to purple).

  <img width=50% src="https://user-images.githubusercontent.com/44863827/151356823-3687e507-1408-411b-ae8a-2b6c5a1259b3.png">

- (optional) assign symbology for each one to print out readable maps. Consider min and max hazard thresholds and classes when building symbology.

  <img width=50% src="https://user-images.githubusercontent.com/44863827/151356576-7f56d2a6-4314-4bcb-9727-377bd032ac54.png">

- Apply min and max thresholds for hazard, if required. In the example, we consider values < 0.5 m as non-impacting due to defence standards, and values > 6 m as likely part of a river body.

    <img width=50% src="https://user-images.githubusercontent.com/44863827/151363110-aef5a83b-d43b-44be-8d81-964133e210e4.png">

<table><tr><td>Original data:</td><td>Threshold applied:</td></tr>
<tr><td><img width=70% src="https://user-images.githubusercontent.com/44863827/151381859-c0b1c778-dd2a-455b-ad36-6077398bd037.png"></td>
<td><img width=70% src="https://user-images.githubusercontent.com/44863827/151381718-74f346ea-8e17-41ae-a055-d683c9e4403e.png"></td></tr></table>

### USING A IMPACT CURVE / FUNCTION

- Raster calculator: tranlate the hazard map (one layer or multiple RP) into impact factor map. In this example, the average flood damage curve for Asia is used, where x is the hazard metric (water depth): y= 0.00723 \* x^3 - 0.1 \* x^2 + 0.506 \* x

  <img width=50% src="https://user-images.githubusercontent.com/44863827/151374810-c7890f1e-8ced-4ecc-be6f-383ab6485bc9.png">

  The resulting impact factor layers RPi has values ranging 0-1.

  <img width=50% src="https://user-images.githubusercontent.com/44863827/151381602-319c426f-273d-482c-ace2-059b6375b4b3.png">

- Raster calculator: multiply the impact factor map with the exposure map

  <img width=50% src="https://user-images.githubusercontent.com/44863827/151382232-4a48272a-6615-4a75-96d8-405c5d4d14e1.png">

  The resulting layer RPi_Pop represent the share of people impacted under RP10.

  <img width=50% src="https://user-images.githubusercontent.com/44863827/151381319-6a9b3fe9-f7f2-4dcd-b497-91bfcaac1c03.png">

- Zonal statistic: select "sum" criteria to aggregate impacted population at ADM3 level.

  <img width=50% src="https://user-images.githubusercontent.com/44863827/151384000-0a71e054-49a8-414b-bf3e-77432b135543.png">
  
  A new column "RP10_pop_sum" is added to ADM3 layer: plot it to desired simbology.
  
  <img width=50% src="https://user-images.githubusercontent.com/44863827/151402320-3ed9a157-59cd-4a5d-8209-312e9aaf0b7c.png">

  In order to express the value as % of total, we need the total population for each ADM3 unit.
  
- Zonal statistic: select "sum" criteria on the Population layer of choice.

If the hazard is represented by **one layer**, it is assumed to represent the Expected Annual Impact (EAI).

Otherwise, this procedure is repeated for **each RP layer**, and then the EAI is computed as described in the following steps.

- Once reapeted over all RP layers, the ADM3 layer used to perform zonal statistic will have all the required information to calculate EAI.

- The impact for each column is multiplied by the year frequency of the return period (RPf), calculated as RPf = 1/RP or, in the case where the set includes RP 1 year, as:
    RPf = 1 - EXP(-1/RP)
    
- 

### USING IMPACT CATEGORIES CLASSIFICATION

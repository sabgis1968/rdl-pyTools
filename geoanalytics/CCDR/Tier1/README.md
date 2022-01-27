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

- Load map data: ADM units (3 layers), hazard (one or as many layers as RP scenarios) and exposure (population map, land cover, etc). In this example, we use FATHOM river flood data.

  <img width=50% src="https://user-images.githubusercontent.com/44863827/151356823-3687e507-1408-411b-ae8a-2b6c5a1259b3.png">

- (optional) assign symbology for each one to print out readable maps. Consider min and max hazard thresholds and classes when building symbology.

  <img width=50% src="https://user-images.githubusercontent.com/44863827/151356576-7f56d2a6-4314-4bcb-9727-377bd032ac54.png">

- Apply min and max thresholds for hazard, if required. In the example, we consider values < 0.5 m as non-impacting due to defence standards, and values > 6 m as likely part of a river body.

    <img width=50% src="https://user-images.githubusercontent.com/44863827/151363110-aef5a83b-d43b-44be-8d81-964133e210e4.png">


<table><tr><td>Original data:</td><td>Threshold applied:</td></tr>
<tr><td><img width=70% src="https://user-images.githubusercontent.com/44863827/151364463-26343f61-a4ab-4a4e-9c53-7a14693da3a4.png"></td>
<td><img width=70% src="https://user-images.githubusercontent.com/44863827/151364627-e57fca34-83af-4738-a3a4-0238a67919e1.png"></td></tr></table>

Note: this computation may take between 1-2 min.

### USING A IMPACT CURVE / FUNCTION

- Raster calculator: tranlate the hazard map (one layer or multiple RP) into impact factor map. In this example, the average flood damage curve for Asia is used, where x is the hazard metric (water depth): y= 0.00723*x^3 - 0.1*x^2 + 0.506*x + 0.023

  <img width=50% src="https://user-images.githubusercontent.com/44863827/151366185-020c0fb4-e506-48f7-ae2b-97f81e5d44d5.png">

Note: this computation may take between 1-2 min. The resulting layers has values ranging 0-1.

  <img width=50% src="https://user-images.githubusercontent.com/44863827/151367325-4d5eacef-f612-486c-803f-05d7d20c0244.png">


- Raster calculator: multiply the impact factor map with the exposure map





### USING IMPACT CATEGORIES CLASSIFICATION

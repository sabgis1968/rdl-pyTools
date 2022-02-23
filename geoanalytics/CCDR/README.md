# CCDR ANALYTICAL NOTEBOOKS
A collection of Python notebooks to perform country-level climate and disaster risk analysis based on global data.

- **Tier 1**: multi-hazard risk screening based on global/regional datasets
- **Tier 2**: hazard-specific, detailed risk evaluation based on mix of regional and local data


# Set up

Create a `.env` file inside the notebook directories with the following:

```
# Environment variables for the CCDR Hazard analysis notebooks

# Fill the below with the location of data files
# Use absolute paths with forward slashes ("/"), and keep the trailing slash
DATA_DIR = ""

# Location to store results of analyses
OUTPUT_DIR = ""

# Location to store downloaded rasters and other data
# for the analysis notebooks
CACHE_DIR = ${DATA_DIR}/cache/
```

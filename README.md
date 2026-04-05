# Phishing-Email-Cleaning

## Overview
This project demonstrates basic data cleaning for phishing email datasets using R.

## Dataset
Raw data includes email fields such as:
- Date
- Sender
- Subject
- Body

## Cleaning Steps
- Removed missing values
- Standardized text format
- Renamed columns
- Added target classification
- Structured dataset for analysis

## Final Schema
- date
- sender
- subject
- body
- target
- label

## How to Run

1. Open R or RStudio
2. Run:

```r
source("scripts/data_cleaning.R")
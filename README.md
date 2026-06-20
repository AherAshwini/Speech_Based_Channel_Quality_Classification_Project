# Speech Based Channel Quality Classification
## Overview
This project simulates wireless channel conditions by adding AWGN noise at different SNR levels (20 dB, 10 dB, and 5 dB) to speech recordings and classifies channel quality into good, medium, and poor categories using machine learning models. 

## Problem Statement
In wireless communication systems, channel quality impacts speech transmission performance. This project explores whether speech features extracted from noisy audio can be used to classify underlying channel quality conditions.

## Technologies
- Python
- PostgreSQL
- Pandas
- Scikit-learn
- Librosa

## Dataset
Google Speech Commands Dataset

## Workflow
1. Load speech samples from Google Speech Commands Dataset.
2. Simulate wireless channel conditions using AWGN at multiple SNR levels.
3. Extract MFCC, Delta MFCC and spectral features using Librosa.
4. Store and analyze extracted features in PostgreSQL.
5. Train Logistic Regression and SVM classifiers.
6. Evaluate model performance on unseen test data.

## Results
- SVM Accuracy: ~92%
- Logistic Regression Accuracy: ~87%

## Repository Structure

```text
├── SQL 			# PostgreSQL queries for data cleaning and analysis
├── artifacts 			# Saved models and generated outputs
├── notebook 			# Exploratory data analysis (EDA) and model model training notebooks
├── src 			# Source code for data generation, feature extraction, and modeling
├── .gitignore
├── README.md
├── requirements.txt
├── setup.py
└── speech_features.csv 	# Extracted speech features dataset
```




# Med-Adhere
This project analyzes medication adherence patterns using a synthetic dataset modeled after pharmacy dispensing records. The goal of the analysis was to identify factors associated with adherence, understand how demographic and dispensing variables relate to adherence behavior, and model the time to non-adherence using survival methods. The analysis was completed in SAS Studio and includes descriptive statistics, logistic regression, and time-to-event modeling.

Methods
Data Preparation

Cleaned records by removing invalid age values and MPR readings outside 0–1.

Standardized the gender variable for consistency.

Created a derived time-to-non-adherence variable using simulated follow-up days.

Descriptive Analysis

Summary statistics were generated for age, days of supply, refill interval, and medication possession ratio (MPR).

Frequency tables were used to examine gender distribution and adherence status.

Predictive Modeling

A logistic regression model was built to determine factors that predict adherence.

Predictors used: age, gender, refill interval, and MPR.

Survival Analysis

Kaplan–Meier curves were used to compare time to non-adherence across gender groups.

A Cox proportional hazards model assessed the impact of age, gender, MPR, and refill interval on the hazard of becoming non-adherent.

Key Findings
Descriptive Results

The dataset included 1,000 patients (523 males, 477 females).

Mean age was approximately 49.9 years.

Average medication possession ratio (MPR) was 0.84.

Overall, 65.4% of patients were classified as adherent.

Predictors of Adherence

MPR was the strongest and most significant predictor of adherence (p < .0001).

Age, gender, and refill interval were not significant contributors in the logistic model.

This indicates that refill behavior (captured by MPR) is the primary determinant of whether a patient remains adherent.

Survival Trends

Kaplan–Meier curves showed that males and females had similar decline patterns in adherence over time, with males maintaining adherence slightly longer.

Median time to non-adherence:

Females: ~41 days

Males: slightly longer than females

Time-to-event differences narrowed over the follow-up period.

Hazard Model Results

Lower MPR increased the hazard of becoming non-adherent, confirming the logistic regression results.

Longer refill intervals also contributed to higher non-adherence risk.

Age and gender had minimal impact on non-adherence time.

Interpretation

The analysis shows that refill behavior captured by the medication possession ratio (MPR); is the central factor in predicting medication adherence. Both logistic regression and survival analysis support this conclusion. Patients with lower MPR values were more likely to become non-adherent and did so earlier in the follow-up period.

Demographic variables such as age and gender had little influence. Refill interval patterns also played a role, with longer intervals associated with increased risk of dropping off therapy.

Overall, the project demonstrates a complete adherence analytics workflow in SAS Studio, from data cleaning to predictive modeling and survival analysis. The findings highlight the importance of monitoring refill patterns to proactively identify patients at risk of non-adherence.

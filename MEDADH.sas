
 /*Medication Adherence Model using synthetic data to analyze non adherence trends*/
/* Step 1: Import CSV data */
proc import datafile="/home/u64333484/medication_adherence_synthetic.csv"
    out=pharmacy
    dbms=csv
    replace;
    getnames=yes;
run;

/* Step 2: Explore dataset structure */
proc contents data=pharmacy; run;
proc print data=pharmacy(obs=10); run;

/* Step 3: Basic data cleaning */
data pharmacy_clean;
    set pharmacy;
    if Age < 0 or Age > 120 then delete;
    if MPR < 0 or MPR > 1 then delete;
    Gender = propcase(Gender);
run;

/* Step 4: Descriptive statistics */
proc means data=pharmacy_clean n mean std min max;
    var Age Days_Supply Refill_Interval MPR;
run;

proc freq data=pharmacy_clean;
    tables Gender Adherence_Status / nocum nopercent;
run;

/* Step 5: Visualization of key variables */
ods graphics on;

proc sgplot data=pharmacy_clean;
    histogram MPR / fillattrs=(color=blue);
    density MPR;
    title "Distribution of Medication Possession Ratio (MPR)";
run;

proc sgplot data=pharmacy_clean;
    vbox MPR / category=Gender;
    title "MPR by Gender";
run;

proc sgplot data=pharmacy_clean;
    scatter x=Age y=MPR / group=Adherence_Status;
    title "Scatterplot of Age vs MPR by Adherence";
run;

/* Step 6: Logistic Regression to predict adherence */
proc logistic data=pharmacy_clean plots=all;
    class Gender (param=ref ref='Male');
    model Adherence_Status(event='1') = Age Gender Refill_Interval MPR;
    title "Logistic Regression Model for Adherence Prediction";
run;

/* Step 7: Create time-to-nonadherence variable for survival analysis */
data pharmacy_surv;
    set pharmacy_clean;
    /* Simulate follow-up days */
    Followup_Days = round(30 + rand("Normal", 0, 10));
    /* Simulate event occurrence: 1 = non-adherent, 0 = censored */
    Event = 1 - Adherence_Status;
run;

/* Step 8: Survival analysis (Kaplan-Meier curves) */
proc lifetest data=pharmacy_surv plots=survival(atrisk=0 to 30 by 5);
    time Followup_Days * Event(0);
    strata Gender;
    title "Kaplan-Meier Survival Curve: Time to Non-Adherence by Gender";
run;


/* Step 9: Cox Proportional Hazards Model */
proc phreg data=pharmacy_surv;
    class Gender (param=ref ref='Male');
    model Followup_Days*Event(0) = Age Gender MPR Refill_Interval;
    title "Cox Regression Model for Predicting Non-Adherence Risk";
run;

ods graphics off;
Introduction 

Asthma affects over 300 million people worldwide (Global Initiative for Asthma, 2023). Its etiology involves a complex interaction between genetics and environmental exposures (Kumari & Nair, 2021). Despite extensive research, the specific impact of smoking—an important environmental factor—on asthma remains controversial (Polosa & Thomson, 2013). 

Several studies have explored the relationship between smoking and asthma, with mixed findings. Some suggest smoking exacerbates symptoms, increases attacks, and raises hospitalization risk (Jayes et al., 2016; Bellou et al., 2022), while others, after adjusting for factors like socioeconomic status, find a non-significant or weakened relationship (Hancox et al., 2016; Cerveri et al., 2012). These discrepancies may result from inconsistent control of key variables, such as age, gender, income, and geography, which influence both asthma severity and smoking behavior. 

Adding to the concern, is that individuals with asthma have been found to smoke at rates similar to or higher than the general population. The WHO reports that smoking prevalence among asthmatics is comparable to non-asthmatics (To et al., 2012), while the CDC states 21% of U.S. asthmatics smoke, compared to 17% of non-asthmatics (CDC, 2013). Rates are higher in the Midwest, South, and among younger asthmatics (27.6%) compared to non-asthmatics (20.4%) (ASH, 2015).  

Given that consensus on the relationship strength between smoking and asthma is still developing, this paper aims to provide deeper insights on the causal inferences on the smoking-asthma relationship. The central research question of this study is:  

What is the impact of smoking on asthma in the U.S.?  

Data Used in This Project:

This project analyzes the relationship between cigarette smoking status and asthma attacks using data from the IPUMS NHIS (National Health Interview Survey).

IPUMS Series
	•	IPUMS NHIS (National Health Interview Survey)
	•	The IPUMS NHIS provides harmonized U.S. health survey data with a focus on health conditions, behaviors, and medical access.
 - SMOKESTATUS2, Current smoking status (Current, Former, Never Smoker)
 - ASTHATAKYR, Had an asthma attack/episode in the past 12 months (Yes/No)

Countries
	•	United States
	•	The NHIS dataset is collected by the U.S. National Center for Health Statistics (NCHS) and covers a representative sample of the U.S. population.

Years
	•	The dataset includes data from 2022 - 2023

How to Access the Data

To access the IPUMS NHIS dataset:
	1.	Go to the IPUMS NHIS website: https://nhis.ipums.org/
	2.	Click on “Get Data” and create a free account if you don’t have one.
	3.	Select the variables relevant to your analysis (Smoking Status, Asthma History, Emergency Visits, etc.).
	4.	Submit your extract request and download the dataset when it becomes available.
	5.	Load the dataset in R using the ipumsr package.

This dataset is publicly available for academic and research purposes.
## Description of how to run the code
Please open RStudio, and open code.rmd and run each block sequentially

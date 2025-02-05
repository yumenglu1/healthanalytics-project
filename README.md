# Introduction to Health Analytics Group Project template
Outline for Introduction to Health Analytics student group project

## Setup Instructions
1. One person from the group should:
    - Fork this repository by following instructions [here](https://docs.github.com/en/pull-requests/collaborating-with-pull-requests/working-with-forks/fork-a-repo). Make sure you rename it!
    - Add the other members of your team to the repository by following the instructions [here](https://docs.github.com/en/account-and-profile/setting-up-and-managing-your-personal-account-on-github/managing-access-to-your-personal-repositories/inviting-collaborators-to-a-personal-repository).

2. All members of the group should then:
    - Sign in to Github and Github Desktop
    - Clone the forked repository to your local computer and open in Github Desktop by following the instructions [here](https://docs.github.com/en/desktop/adding-and-cloning-repositories/cloning-a-repository-from-github-to-github-desktop).
    - Make a change to your local copy of the repo (e.g. add a test file), commit that change and then push to the master using the instructions [here](https://docs.github.com/en/desktop/making-changes-in-a-branch/committing-and-reviewing-changes-to-your-project-in-github-desktop). Ignore the information about branches - for now you can just work on the main branch.

Data Used in This Project

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
	•	The dataset includes data from [INSERT YEAR RANGE YOU USED, e.g., 2015-2022].

How to Access the Data

To access the IPUMS NHIS dataset:
	1.	Go to the IPUMS NHIS website: https://nhis.ipums.org/
	2.	Click on “Get Data” and create a free account if you don’t have one.
	3.	Select the variables relevant to your analysis (Smoking Status, Asthma History, Emergency Visits, etc.).
	4.	Submit your extract request and download the dataset when it becomes available.
	5.	Load the dataset in R using the ipumsr package.

This dataset is publicly available for academic and research purposes.
## Description of how to run the code
Here you should explain how someone could replicate the analysis in your report. If there are several code files, explain what each of them does.


packages <- c("dplyr", "ggplot2", "broom", "tidyr","srvyr", "survey", "ipumsr",  "here", "car", "kableExtra", "modelsummary")
package.check <- lapply(
  packages,
  FUN = function(x) {
    if (!require(x, character.only = TRUE)) {
      install.packages(x, dependencies = TRUE)
      library(x, character.only = TRUE)
    }
  }
)

ddi <- read_ipums_ddi("nhis_00008.xml")
data <- read_ipums_micro(ddi)
str(data)
summary(data)
names(data)

filtered_data <- data %>%
  mutate(
    SMOKING_LEVEL = case_when(
      CIGSDAY >= 1 & CIGSDAY <= 10 ~ "Light smoker",
      CIGSDAY >= 11 & CIGSDAY <= 20 ~ "Moderate smoker",
      CIGSDAY >= 21             ~ "Heavy smoker"
    ),
    SMOKING_LEVEL = factor(
      SMOKING_LEVEL,
      levels = c("Light smoker", "Moderate smoker", "Heavy smoker")
    ),
    has_asthma = if_else(ASTHMAEV > 0, 1, 0),
    visited_er = if_else(ASTHATAKYR > 0, 1, 0)
  )

filtered_data <- filtered_data %>%
  mutate(
    smoking_combined = case_when(
      SMOKESTATUS2 %in% c(10, 11, 12, 13) & CIGSDAY >= 1 & CIGSDAY <= 10  ~ "Current smoker, Light",
      SMOKESTATUS2 %in% c(10, 11, 12, 13) & CIGSDAY >= 11 & CIGSDAY <= 20 ~ "Current smoker, Moderate",
      SMOKESTATUS2 %in% c(10, 11, 12, 13) & CIGSDAY >= 21             ~ "Current smoker, Heavy",
      SMOKESTATUS2 %in% c(20, 30) ~ "Non-smoker",
      TRUE ~ "Unknown"
    )
  )

filtered_data$smoking_combined <- factor(filtered_data$smoking_combined,
                                         levels = c("Non-smoker", "Current smoker, Light", "Current smoker, Moderate", "Current smoker, Heavy", "Unknown")
)

table(filtered_data$smoking_combined)
table(filtered_data$SMOKING_LEVEL)
table(filtered_data$has_asthma)
table(filtered_data$visited_er)

survey_data <- svydesign(
  ids = ~PSU,
  strata = ~STRATA,
  data = filtered_data,
  weights = ~SAMPWEIGHT,
  nest = TRUE
)

model_asthma <- svyglm(
  has_asthma ~ SMOKING_LEVEL, 
  design = survey_data, 
  family = quasibinomial()
)
summary(model_asthma)

model_er <- svyglm(
  visited_er ~ SMOKING_LEVEL, 
  design = survey_data, 
  family = quasibinomial()
)
summary(model_er)

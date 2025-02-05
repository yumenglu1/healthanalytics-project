# Install and load necessary packages
packages <- c("dplyr", "ggplot2", "broom", "tidyr","srvyr", "survey", "ipumsr", "here", "car", "kableExtra", "modelsummary")

package.check <- lapply(
  packages,
  FUN = function(x) {
    if (!require(x, character.only = TRUE)) {
      install.packages(x, dependencies = TRUE)
      library(x, character.only = TRUE)
    }
  }
)

# Set working directory
setwd(here())

# Load dataset
ddi <- read_ipums_ddi("nhis_00008.xml")
data <- read_ipums_micro(ddi)

# Data cleaning and transformation
filtered_data <- data %>%
  mutate(
    SMOKING_LEVEL = case_when(
      CIGSDAY >= 1 & CIGSDAY <= 10 ~ "Light smoker",
      CIGSDAY >= 11 & CIGSDAY <= 20 ~ "Moderate smoker",
      CIGSDAY >= 21             ~ "Heavy smoker"
    ),
    SMOKING_LEVEL = factor(SMOKING_LEVEL, levels = c("Light smoker", "Moderate smoker", "Heavy smoker")),
    has_asthma = if_else(ASTHMAEV > 0, 1, 0),
    visited_er = if_else(ASTHATAKYR > 0, 1, 0)
  ) %>%
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

# Tables for verification
table(filtered_data$smoking_combined)
table(filtered_data$SMOKING_LEVEL)
table(filtered_data$has_asthma)
table(filtered_data$visited_er)

# Survey design setup
survey_data <- svydesign(
  ids = ~PSU,
  strata = ~STRATA,
  data = filtered_data,
  weights = ~SAMPWEIGHT,
  nest = TRUE
)

# Logistic regression models
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


library(kableExtra)

# Table 1: Smoking Levels Distribution
smoking_table <- filtered_data %>%
  group_by(smoking_combined) %>%
  summarise(Count = n()) %>%
  kable(format = "html", caption = "Distribution of Smoking Levels") %>%
  kable_styling()

print(smoking_table)

# Table 2: Asthma vs. Smoking Level
asthma_table <- filtered_data %>%
  group_by(smoking_combined, has_asthma) %>%
  summarise(Count = n()) %>%
  pivot_wider(names_from = has_asthma, values_from = Count, names_prefix = "Asthma_") %>%
  kable(format = "html", caption = "Asthma Cases by Smoking Level") %>%
  kable_styling()

print(asthma_table)

# Table 3: ER Visits vs. Smoking Level
er_table <- filtered_data %>%
  group_by(smoking_combined, visited_er) %>%
  summarise(Count = n()) %>%
  pivot_wider(names_from = visited_er, values_from = Count, names_prefix = "ER_") %>%
  kable(format = "html", caption = "ER Visits by Smoking Level") %>%
  kable_styling()

print(er_table)


library(ggplot2)

ggplot(filtered_data, aes(x = smoking_combined)) +
  geom_bar(fill = "steelblue") +
  labs(title = "Distribution of Smoking Levels", x = "Smoking Level", y = "Count") +
  theme_minimal()

ggplot(filtered_data, aes(x = smoking_combined, fill = factor(has_asthma))) +
  geom_bar(position = "fill") +  # Stacked bar chart normalized
  labs(title = "Asthma Prevalence by Smoking Level", x = "Smoking Level", y = "Proportion", fill = "Has Asthma") +
  theme_minimal()

ggplot(filtered_data, aes(x = smoking_combined, fill = factor(visited_er))) +
  geom_bar(position = "fill") +  
  labs(title = "ER Visits by Smoking Level", x = "Smoking Level", y = "Proportion", fill = "Visited ER") +
  theme_minimal()

library(modelsummary)

models <- list(
  "Asthma Model" = model_asthma,
  "ER Visits Model" = model_er
)

modelsummary(models, output = "markdown")
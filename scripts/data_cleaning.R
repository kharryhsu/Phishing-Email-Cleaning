library(dplyr)
library(stringr)
library(readr)

# Load dataset
data <- read_csv("../data/Phishing_Email.csv")

# Inspect
print(head(data))

# Remove useless index column
data <- data %>%
  select(-`...1`)

# Rename columns
data <- data %>%
  rename(
    body = `Email Text`,
    label = `Email Type`
  )

# Clean text
data <- data %>%
  mutate(
    body = str_squish(body)
  )

# Standardize label
data <- data %>%
  mutate(
    label = ifelse(label == "Phishing Email", "phishing", "safe")
  )

# Add target (simple logic)
data <- data %>%
  mutate(
    target = case_when(
      str_detect(body, "bank|account|verify") ~ "banking users",
      str_detect(body, "order|purchase|amazon") ~ "e-commerce users",
      TRUE ~ "general public"
    )
  )

# Final dataset
clean_data <- data %>%
  select(body, target, label)

# Save
write_csv(clean_data, "../data/cleaned_phishing_emails.csv")

print("Cleaning complete.")
library(dplyr)
library(stringr)
library(readr)

# Load dataset
data <- read_csv("../data/Phishing_Email.csv")

# Inspect
print(head(data))

# ----------------------------
# 1. Basic cleaning
# ----------------------------

data <- data |>
  select(-`...1`) |>
  rename(
    body = `Email Text`,
    label = `Email Type`
  ) |>
  mutate(
    body = coalesce(body, ""),
    body = str_to_lower(body),
    body = str_squish(body)
  )

# ----------------------------
# 2. Standardize label
# ----------------------------

data <- data |>
  mutate(
    label = case_when(
      str_detect(str_to_lower(label), "phish") ~ "phishing",
      TRUE ~ "safe"
    )
  )

# ----------------------------
# 3. Feature engineering
# ----------------------------

data <- data |>
  mutate(
    has_link = as.integer(str_detect(body, "http|www")),
    has_urgency = as.integer(str_detect(body, "\\burgent\\b|\\bimmediately\\b|\\bnow\\b|\\bverify\\b")),
    text_length = nchar(body),
    num_exclamations = str_count(body, "!"),
    num_digits = str_count(body, "[0-9]")
  )

# ----------------------------
# 4. Keyword-based category (optional but safe)
# ----------------------------

data <- data |>
  mutate(
    keyword_category = case_when(
      str_detect(body, "bank|account|login|password") ~ "banking",
      str_detect(body, "order|purchase|amazon|shipping") ~ "ecommerce",
      str_detect(body, "security|verify|alert|suspend") ~ "security",
      TRUE ~ "general"
    )
  )

# ----------------------------
# 5. Final dataset
# ----------------------------

clean_data <- data |>
  select(
    body,
    label,
    has_link,
    has_urgency,
    text_length,
    num_exclamations,
    num_digits,
    keyword_category
  )

# Inspect
glimpse(clean_data)

# Save
write_csv(clean_data, "../data/cleaned_phishing_emails.csv")

print("Cleaning complete.")
import pandas as pd

df = pd.read_csv("../data/cleaned_phishing_emails.csv")

with open("../data/cleaned_phishing_emails.md", "w", encoding="utf-8") as f:
    for i, row in df.iterrows():
        f.write(f"### Record {i+1}\n")
        for col in df.columns:
            f.write(f"- {col}: {row[col]}\n")
        f.write("\n")
        
print("Converted Complete")
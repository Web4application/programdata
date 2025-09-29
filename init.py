import pandas as pd

# Input / Output file names
input_file = "Web4application_Repos.md"
output_file = "Web4application_Repos.xlsx"

# Read Markdown table
df = pd.read_csv(
    input_file,
    sep="|",
    engine="python",
    skiprows=2,                  # skip header separator lines
    names=["Repository", "https://github.com/Web4application?tab=repositories"],# set column names
    usecols=[1, 2]               # select only useful columns
)

# Clean up whitespace
df["Repository"] = df["Repository"].str.strip()
df["Link"] = df["Link"].str.strip()

# Save to Excel
df.to_excel(output_file, index=False)
print(f"✅ Saved as {output_file}")

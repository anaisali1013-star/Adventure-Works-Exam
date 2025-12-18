--NAGER API Python code run on Jupyter Notebook

import requests
import pandas as pd

def get_holidays(year, country):
    url = f"https://date.nager.at/api/v3/PublicHolidays/{year}/{country}"
    response = requests.get(url)
    
    if response.status_code != 200:
        raise Exception(f"Error {response.status_code}: {response.text}")
    
    data = response.json()
    df = pd.DataFrame(data)
    
    # Keep only useful fields
    df = df[["date", "localName", "name", "countryCode", "fixed", "global", "counties"]]
    df["date"] = pd.to_datetime(df["date"])
    
    return df

# country list
countries = ["AU", "US", "DE", "FR", "CA", "GB"]
years = [2015, 2016, 2017]

# download all documents 
holidays_list = []
for country in countries:
    for year in years:
        df = get_holidays(year, country)
        holidays_list.append(df)

# Add all to single DataFrame
holidays_global = pd.concat(holidays_list, ignore_index=True)

# Save as CSV
holidays_global.to_csv("holidays_global.csv", index=False)

holidays_global.head()

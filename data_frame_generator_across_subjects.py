import glob
import pandas as pd

# glob.glob('data*.csv') - returns List[str]
# pd.read_csv(f) - returns pd.DataFrame()
# for f in glob.glob() - returns a List[DataFrames]
# pd.concat() - returns one pd.DataFrame()
df = pd.concat([pd.read_csv(data, comment='#', na_values='None') for data in glob.glob('*.xpd')], ignore_index = True)


df.to_csv("all_reaction_times.csv")
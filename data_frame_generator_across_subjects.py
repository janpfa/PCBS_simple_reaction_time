import glob
import pandas as pd

df = pd.concat([pd.read_csv(data, comment='#', na_values='None') for data in glob.glob('*.xpd')], ignore_index = True)

df.to_csv("all_reaction_times.csv")
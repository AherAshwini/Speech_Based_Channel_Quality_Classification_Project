### Import required libraries.
import pandas as pd
import sqlalchemy

### Read 'speech_features.csv' file
df = pd.read_csv("speech_features.csv")

### Create SQLALchemy engine.
engine = sqlalchemy.create_engine("postgresql+psycopg2://postgres:Ganesh1912@localhost:5433/Speech_Based_Channel_Quality_Classification_Project")
conn = engine.connect()

### Load the pandas dataframe to PostgreSQL 'speech_features' table
df.to_sql('speech_features', con = conn, index=False, if_exists="append")
conn.close()



# ### Load the Pandas dataframe to PostgreSQL 'sinr_data' table.
# df.to_sql('sinr_data', con=conn, index=False, if_exists="append")
# conn.close()
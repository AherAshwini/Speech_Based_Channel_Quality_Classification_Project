import os
import sqlalchemy
from dotenv import load_dotenv

load_dotenv()

def get_engine():
    db_url = os.getenv("DB_URL")
    engine = sqlalchemy.create_engine(db_url)
    return engine
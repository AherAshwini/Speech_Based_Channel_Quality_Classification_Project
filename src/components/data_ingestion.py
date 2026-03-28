import sys
import os
from src.exception import CustomException
from src.logger import logger
from src.config.database import get_engine
from src.config.configuration import DataIngestionConfig
import pandas as pd

from sklearn.model_selection import train_test_split


class DataIngestion:
    def __init__(self):
        self.ingestion_config=DataIngestionConfig()

    def initiate_data_ingestion(self):
        logger.info("Entered the data ingestion component")

        try:
            engine = get_engine()

            query1 = f"SELECT * FROM {self.ingestion_config.table1_name}"
            df_with_outliers = pd.read_sql(query1, engine)

            logger.info(f"Loaded data from table: {self.ingestion_config.table1_name}")

            query2 = f"SELECT * FROM {self.ingestion_config.table2_name}"
            df_without_outliers = pd.read_sql(query2, engine)

            logger.info(f"Loaded data from table: {self.ingestion_config.table2_name}")

            ##Create artifacts folder.
            os.makedirs(os.path.dirname(self.ingestion_config.train_data_with_outliers_path), exist_ok=True)

            ##Save raw data to csv 
            df_with_outliers.to_csv(self.ingestion_config.raw_data_with_outliers_path, index=False, header=True)
            df_without_outliers.to_csv(self.ingestion_config.raw_data_without_outliers_path, index=False, header=True)

            logger.info("Train test split initiated")

            train_w, test_w = train_test_split(df_with_outliers, test_size=0.2, random_state=42)
            train_wo, test_wo = train_test_split(df_without_outliers, test_size=0.2, random_state=42)

            ##Save to csv files
            train_w.to_csv(self.ingestion_config.train_data_with_outliers_path, index=False, header=True)
            test_w.to_csv(self.ingestion_config.test_data_with_outliers_path, index=False, header=True)

            train_wo.to_csv(self.ingestion_config.train_data_without_outliers_path, index=False, header=True)
            test_wo.to_csv(self.ingestion_config.test_data_without_outliers_path, index=False, header=True)

            logger.info("Ingestion of the data is completed")

            return(
                self.ingestion_config.train_data_with_outliers_path,
                self.ingestion_config.test_data_with_outliers_path,
                self.ingestion_config.train_data_without_outliers_path,
                self.ingestion_config.test_data_without_outliers_path,
            )

        except Exception as e:
            raise CustomException(e,sys)
         

if __name__ == '__main__':
    obj = DataIngestion()
    train_w, test_w, train_wo, test_wo = obj.initiate_data_ingestion()


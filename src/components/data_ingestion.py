import sys
import os
import pandas as pd
from sklearn.model_selection import train_test_split

from src.exception import CustomException
from src.logger import logger
from src.config.database import get_engine
from src.config.configuration import DataIngestionConfig
from src.components.data_transformation import DataTransformation
from src.components.model_trainer import ModelTrainer 
from src.config.configuration import DataTransofmationConfig, ModelTrainerConfig


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

    data_transformation = DataTransformation()
    train_arr_w, test_arr_w, preprocessor_w, label_encoder_w = data_transformation.initiate_data_transformation_w(train_w, test_w)
    train_arr_wo, test_arr_wo, preprocessor_wo, label_encoder_wo = data_transformation.initiate_data_transformation_wo(train_wo, test_wo)

    modeltrainer = ModelTrainer()
    acc_score_with_outliers = modeltrainer.initiate_model_trainer_w(
        train_array_w=train_arr_w,test_array_w=test_arr_w)
    acc_score_without_outliers = modeltrainer.initiate_model_trainer_wo(
        train_array_wo=train_arr_wo,test_array_wo=test_arr_wo)
    
    print(f"Accuracy score (with outliers): {acc_score_with_outliers}")
    print(f"Accuracy score (without outliers): {acc_score_without_outliers}")




import sys
import os
from dataclasses import dataclass
import numpy as np
import pandas as pd
from sklearn.pipeline import Pipeline
from sklearn.preprocessing import StandardScaler, LabelEncoder
from sklearn.compose import ColumnTransformer

from src.exception import CustomException
from src.logger import logger
from src.config.configuration import DataTransofmationConfig
from src.utils import save_object


class DataTransformation:
    def __init__(self):
        self.data_transformation_config = DataTransofmationConfig()

    def get_data_transformer_object(self):
        '''
        This function is responsible for data transformation.
        '''
        try:
            numerical_columns = ['mfcc_1','mfcc_2','mfcc_3','mfcc_4','mfcc_5','mfcc_6','mfcc_7','mfcc_8','mfcc_9',
                                 'mfcc_10','mfcc_11','mfcc_12','mfcc_13','delta_mfcc_1','delta_mfcc_2','delta_mfcc_3',
                                 'delta_mfcc_4','delta_mfcc_5','delta_mfcc_6','delta_mfcc_7','delta_mfcc_8',
                                 'delta_mfcc_9','delta_mfcc_10','delta_mfcc_11','delta_mfcc_12','delta_mfcc_13',
                                 'zcr','centroid','flatness','ste']
            label_column = ['channel_quality'] 

            num_pipeline = Pipeline(
                steps=[
                    ("scaler", StandardScaler())
                ]
            )

            preprocessor = ColumnTransformer(
                [
                    ("num_pipeline", num_pipeline, numerical_columns)
                ]
            )
            
            logger.info("Numerical columns standard scaling completed.")
        
            return preprocessor

        except Exception as e:
            raise CustomException(e,sys)
    
    def initiate_data_transformation_w(self, train_path_w, test_path_w):
        try:
            train_df_w = pd.read_csv(train_path_w)
            test_df_w = pd.read_csv(test_path_w)

            logger.info("Read train and test data (with outliers).")

            train_df_w = train_df_w.drop(columns=['snr'])
            test_df_w = test_df_w.drop(columns=['snr'])

            logger.info("Obtaining preprocessing object.")

            preprocessor_obj_w = self.get_data_transformer_object()

            target_column_name = 'channel_quality'

            input_feature_train_df_w = train_df_w.drop(columns=[target_column_name])
            target_feature_train_df_w = train_df_w[target_column_name]

            input_feature_test_df_w = test_df_w.drop(columns=[target_column_name])
            target_feature_test_df_w = test_df_w[target_column_name]


            logger.info("Applying preprocessing object on training and testing dataframe.")


            input_feature_train_arr_w = preprocessor_obj_w.fit_transform(input_feature_train_df_w)
            input_feature_test_arr_w = preprocessor_obj_w.transform(input_feature_test_df_w)

            le1 = LabelEncoder()
            target_feature_train_df_w = le1.fit_transform(target_feature_train_df_w)
            target_feature_test_df_w = le1.transform(target_feature_test_df_w)

            
            train_arr_w = np.c_[
                input_feature_train_arr_w, 
                np.array(target_feature_train_df_w)
            ]

            test_arr_w = np.c_[
                input_feature_test_arr_w,
                np.array(target_feature_test_df_w)                               
            ]

            save_object(
                file_path = self.data_transformation_config.preprocessor_obj_file_path_w,
                obj = preprocessor_obj_w
            )

            save_object(
                file_path = self.data_transformation_config.label_encoder_file_path_w,
                obj = le1
            )


            return(
                train_arr_w,
                test_arr_w,
                self.data_transformation_config.preprocessor_obj_file_path_w,
                self.data_transformation_config.label_encoder_file_path_w
            )
        
        
        except Exception as e:
            raise CustomException(e,sys)
        
    def initiate_data_transformation_wo(self, train_path_wo, test_path_wo):
        try:
            train_df_wo = pd.read_csv(train_path_wo)
            test_df_wo = pd.read_csv(test_path_wo)

            logger.info("Read train and test data (without outliers).")

            train_df_wo = train_df_wo.drop(columns=['snr'])
            test_df_wo = test_df_wo.drop(columns=['snr'])

            logger.info("Obtaining preprocessing object.")

            preprocessor_obj_wo = self.get_data_transformer_object()

            target_column_name = "channel_quality"

            input_feature_train_df_wo = train_df_wo.drop(columns=[target_column_name])
            target_feature_train_df_wo = train_df_wo[target_column_name]

            input_feature_test_df_wo = test_df_wo.drop(columns=[target_column_name])
            target_feature_test_df_wo = test_df_wo[target_column_name]

            logger.info("Applying preprocessing object on training and testing dataframe.")

            input_feature_train_arr_wo = preprocessor_obj_wo.fit_transform(input_feature_train_df_wo)
            input_feature_test_arr_wo = preprocessor_obj_wo.transform(input_feature_test_df_wo)

            le2 = LabelEncoder()
            target_feature_train_df_wo = le2.fit_transform(target_feature_train_df_wo)
            target_feature_test_df_wo = le2.transform(target_feature_test_df_wo)
            

            train_arr_wo = np.c_[
                input_feature_train_arr_wo,
                np.array(target_feature_train_df_wo)
            ]

            test_arr_wo = np.c_[
                input_feature_test_arr_wo,
                np.array(target_feature_test_df_wo)
            ]

            save_object(
                file_path = self.data_transformation_config.preprocessor_obj_file_path_wo,
                obj = preprocessor_obj_wo
            )

            save_object(
                file_path = self.data_transformation_config.label_encoder_file_path_wo,
                obj = le2
            )

            return(
                train_arr_wo,
                test_arr_wo,
                self.data_transformation_config.preprocessor_obj_file_path_wo,
                self.data_transformation_config.label_encoder_file_path_wo
            )

        except Exception as e:
            raise CustomException(e,sys)
        

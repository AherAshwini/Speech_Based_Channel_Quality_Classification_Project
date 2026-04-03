import os
import sys
from dataclasses import dataclass

from sklearn.linear_model import LogisticRegression
from sklearn.svm import SVC
from sklearn.metrics import accuracy_score, precision_score, recall_score, f1_score

from src.exception import CustomException
from src.logger import logger
from src.config.configuration import ModelTrainerConfig

from src.utils import save_object, evaluate_models

class ModelTrainer:
    def __init__(self):
        self.model_trainer_config = ModelTrainerConfig()

    def initiate_model_trainer_w(self, train_array_w, test_array_w):
        try:
            logger.info("Split train and test input data")
            X_train_w, y_train_w, X_test_w, y_test_w = (
                train_array_w[:,:-1],
                train_array_w[:,-1],
                test_array_w[:,:-1],
                test_array_w[:,-1]
            )
            models = {
                "LogisticRegression": LogisticRegression(),
                "SVM": SVC()
            }

            model_report:dict = evaluate_models(X_train=X_train_w, y_train=y_train_w, 
                                                X_test=X_test_w,y_test=y_test_w,models=models)
            
            best_model_score = max(sorted(model_report.values()))

            best_model_name = list(model_report.keys())[
                list(model_report.values()).index(best_model_score)
            ]

            best_model = models[best_model_name]

            if best_model_score<0.6:
                raise CustomException("No best model found")
            
            best_model.fit(X_train_w, y_train_w)
            
            logger.info(f"Best model found on training and testing dataset (with outliers) is {best_model}")

            save_object(
                file_path=self.model_trainer_config.trained_model_file_path,
                obj = best_model
            )

            predicted = best_model.predict(X_test_w)
            acc_score_w = accuracy_score(y_test_w,predicted)

            return acc_score_w
        
        except Exception as e:
            raise CustomException(e,sys)
        
    def initiate_model_trainer_wo(self, train_array_wo, test_array_wo):
        try:
            logger.info("Split train and test input data")
            X_train_wo, y_train_wo, X_test_wo, y_test_wo = (
                train_array_wo[:,:-1],
                train_array_wo[:,-1],
                test_array_wo[:,:-1],
                test_array_wo[:,-1]
            )
            models = {
                "LogisticRegression": LogisticRegression(),
                "SVM": SVC()
            }

            model_report:dict = evaluate_models(X_train=X_train_wo, y_train=y_train_wo, 
                                                X_test=X_test_wo,y_test=y_test_wo,models=models)
            
            best_model_score_wo = max(sorted(model_report.values()))

            best_model_name_wo = list(model_report.keys())[
                list(model_report.values()).index(best_model_score_wo)
            ]

            best_model_wo = models[best_model_name_wo]

            if best_model_score_wo<0.6:
                raise CustomException("No best model found")
            
            best_model_wo.fit(X_train_wo, y_train_wo)
            
            logger.info(f"Best model found on training and testing dataset (without outliers) is {best_model_wo}")

            save_object(
                file_path=self.model_trainer_config.trained_model_file_path,
                obj = best_model_wo
            )

            predicted = best_model_wo.predict(X_test_wo)
            acc_score_wo = accuracy_score(y_test_wo,predicted)

            return acc_score_wo
            
            

        except Exception as e:
            raise CustomException(e,sys)
        
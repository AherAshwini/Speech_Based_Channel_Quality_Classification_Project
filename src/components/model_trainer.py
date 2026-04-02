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

    def initiate_model_trainer(self, train_array_w, test_array_w):
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
            
            logger.info(f"Best model found on training and testing dataset is {best_model}")

            save_object(
                file_path=self.model_trainer_config.trained_model_file_path,
                obj = best_model
            )

            predicted = best_model.predict(X_test_w)
            acc_score = accuracy_score(y_test_w,predicted)

            return acc_score
            

        except Exception as e:
            raise CustomException(e,sys)
        
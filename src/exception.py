import sys
from src.logger import logger

class CustomException(Exception):

    def __init__(self,error,error_detail:sys):
        super().__init__(error)

        _,_,exc_tb = error_detail.exc_info()

        file_name = exc_tb.tb_frame.f_code.co_filename
        line_number = exc_tb.tb_lineno

        self.error_message = f"""
Error occured in script: {file_name}
Line number: {line_number}
Error message: '{error}'
"""

    def __str__(self):
        return self.error_message
    

   


    

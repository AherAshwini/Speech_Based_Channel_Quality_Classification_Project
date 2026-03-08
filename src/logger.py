import os
import logging
from datetime import datetime

log_file = f"{datetime.now().strftime('%Y-%m-%d-%H-%M-%S-log')}.log"
log_dir = "Logs"
os.makedirs(log_dir, exist_ok=True)
log_file_path = os.path.join(log_dir,log_file)

logging.basicConfig(
    filename = log_file_path,
    level = logging.INFO,
    format = "%(asctime)s - %(levelname)s - %(filename)s - %(message)s "
)


logger = logging.getLogger()


from src.data_generation.data_loader import get_random_audio_files
from src.config.config import DATASET_PATH, NUM_AUDIO_FILES, IGNORE_FOLDERS

selected_audio_files = get_random_audio_files(DATASET_PATH, IGNORE_FOLDERS, NUM_AUDIO_FILES)



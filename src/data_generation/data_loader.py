### Import required libraries.
import random 
from src.logger import logger


### This function will return the list of randomly selected audio files path.

def get_random_audio_files(dataset_path, ignore_folders, no_files):

    logger.info(f"Dataset loaded: {dataset_path}")

    files = list(dataset_path.rglob("*.wav"))
    logger.info("Created list of audio files path from dataset.")
    logger.info(f"Total audio files: {len(files)}")

    logger.info(f"Ignored folders: {ignore_folders}")

    filtered_files = [f for f in files if not any(folder in ignore_folders for folder in f.parts)]
    logger.info("Filtered audio files after removing ignored folders.")

    logger.info(f"After filtering available audio files: {len(filtered_files)}")

    if no_files > len(filtered_files):

        logger.error(f"Number of audio files is greater than number of filtered files. "
                     "Please check 'NUM_AUDIO_FILES' parameter value in 'config.py' file.")
        
        raise ValueError(f"'NUM_AUDIO_FILES' is greater than available filtered audio files.")
        
    selected_files = random.sample(filtered_files, no_files)
    logger.info(f"Randomly selected {no_files} audio files.")

    return selected_files




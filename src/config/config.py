from pathlib import Path

### Path of downloaded data.
DATASET_PATH = Path("C:\\Users\\ahera\\Downloads\\Speech_channel_quality_project_downloaded_data\\archive")

### Number of selected audio files.
NUM_AUDIO_FILES = 5000

### Folders need to be ignored from raw dataset folder.
IGNORE_FOLDERS = ['_background_noise_']

### Below SNR levels are considered for this project.
SNR_LEVELS = [20, 10, 5]

#### Number of MFCC Features.
NUM_MFCC = 13

### Frame Length
FRAME_LENGTH = 2048

### Hop length
HOP_LENGTH = 512




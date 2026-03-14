import librosa
import numpy as np

### Below function will load audio signal
def load_audio(audio_file_path):

    signal, sr = librosa.load(audio_file_path, sr=None)
    
    return signal, sr
        
### This function will compute siganl power.
def compute_signal_power(signal):

    signal_power = np.mean((signal)**2)

    return signal_power

### Below function will simulate AWGN channel and return noisy signal.
def add_awgn_noise(signal, snr_db):

    snr_linear = 10**(snr_db/10)

    signal_power = compute_signal_power(signal)

    noise_power = signal_power/snr_linear

    noise = np.sqrt(noise_power) * np.random.randn(len(signal))

    noisy_signal = signal + noise

    return noisy_signal



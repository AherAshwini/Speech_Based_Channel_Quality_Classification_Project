import librosa
import numpy as np

### Below function will calculate speech features from given speech signal.
def extract_features(noisy_signal,sr,n_mfcc, frame_length, hop_length):

    mfcc = librosa.feature.mfcc(y = noisy_signal, sr=sr, n_mfcc=n_mfcc)
    mfcc_mean = np.mean(mfcc, axis=1)

    delta_mfcc = librosa.feature.delta(mfcc)
    delta_mfcc_mean = np.mean(delta_mfcc, axis=1)

    zcr = librosa.feature.zero_crossing_rate(noisy_signal)
    zcr_mean = np.mean(zcr)

    centroid = librosa.feature.spectral_centroid(y=noisy_signal, sr=sr)
    centroid_mean = np.mean(centroid)

    flatness = librosa.feature.spectral_flatness(y=noisy_signal)
    flatness_mean = np.mean(flatness)

    frames = librosa.util.frame(noisy_signal, frame_length=frame_length, hop_length=hop_length)
    ste = np.sum(frames**2, axis=0)
    ste_mean = np.mean(ste)

    return mfcc_mean, delta_mfcc_mean, zcr_mean, centroid_mean, flatness_mean, ste_mean

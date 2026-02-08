

⚠️ **IMPORTANT SAFETY WARNING** ⚠️
<div style="background-color: #ff0000; color: white; padding: 15px; border-radius: 5px; margin: 20px 0;">
<strong>⚠️ DO NOT USE HEADPHONES WHEN LISTENING TO AUDIO SAMPLES! ⚠️</strong>
<br><br>
The audio files in this project contain high-frequency interference signals (4-6 kHz range) that may cause discomfort or potential hearing damage when played through headphones at normal volume levels. 
<br><br>
<strong>Always use external speakers at low volume when testing audio outputs.</strong>
</div>


# DSP Filter Design Tool 🎵🔧
A comprehensive MATLAB-based FIR filter design tool featuring three filter design methods (Windowed Sinc, Least Squares, Weighted Least Squares) with a graphical user interface for audio signal filtering and noise removal.

[![Watch the video](images/youtube_window_1.png)](https://www.youtube.com/embed/PaxfoU3UQfo?si=ohvDeF--APN1G6Hf)

## 📋 Description

This project implements a complete FIR filter design tool that allows users to design, visualize, and apply digital filters to audio signals. The system removes high-frequency interference from audio signals using three different filter design methodologies, providing comprehensive comparison of their performance characteristics.

The implementation includes a MATLAB App Designer GUI that enables real-time parameter adjustment, visualization of magnitude responses in both linear and logarithmic scales, and immediate audio filtering results.

<br>
<div align="center">
  <a href="https://codeload.github.com/TendoPain18/dsp-filter-design-tool/legacy.zip/main">
    <img src="https://img.shields.io/badge/Download-Files-brightgreen?style=for-the-badge&logo=download&logoColor=white" alt="Download Files" style="height: 50px;"/>
  </a>
</div>

## 🎯 Project Objectives

1. **Develop FIR Filter Design Methods**: Windowed Sinc, Least Squares (LS), Weighted LS
2. **Implement Window Functions**: Rectangular, Blackman, Chebyshev, Kaiser
3. **Create Interactive GUI**: User-friendly interface for parameter control
4. **Remove Audio Interference**: Filter sinusoidal noise from audio signals
5. **Compare Filter Performance**: Analyze complexity vs. performance trade-offs
6. **Visualize Magnitude Response**: Both linear and logarithmic scales

## ✨ Features

### Filter Design Methods
- **Windowed Sinc Method**: Ideal low-pass filter with windowing
- **Least Squares (LS)**: Minimize squared error in frequency domain
- **Weighted Least Squares (WLS)**: Emphasize different frequency bands

### Window Functions
- **Rectangular**: Simplest, sharp cutoff, high sidelobes
- **Blackman**: Smooth transition, low sidelobes
- **Chebyshev**: Equiripple stopband, configurable ripple
- **Kaiser**: Adjustable trade-off between main lobe width and sidelobe level

### GUI Capabilities
- **Method Selection**: Choose filter design method
- **Window Selection**: Four different window types
- **Parameter Input**: Filter length, cutoff frequency, desired points
- **Scale Toggle**: Linear or logarithmic magnitude display
- **Real-Time Processing**: Immediate filter coefficient generation
- **Audio Playback**: Listen to filtered results

### Audio Processing
- **Signal Upsampling**: 2× upsampling using MATLAB resample
- **Interference Addition**: Multiple sinusoidal components (4-6 kHz)
- **Multi-Stage Filtering**: Triple filtering for enhanced noise reduction
- **Spectrum Visualization**: Before and after filtering comparison

## 🔬 Theoretical Background

### FIR Filter Design Methods

#### 1. Windowed Sinc Method

**Ideal Low-Pass Filter (Frequency Domain):**
```
H_ideal(ω) = {
    1,  |ω| ≤ ωc
    0,  ωc < |ω| ≤ π
}
```

**Impulse Response (Time Domain):**
```
h[n] = 2fc · sinc(2fc · n)
```

**Windowed Coefficients:**
```
h_windowed[n] = h[n] · w[n]
```

Where `w[n]` is the selected window function.

#### 2. Least Squares Method

**Objective:** Minimize squared error between desired and actual response
```
min Σ |H(ω_k) - H_d(ω_k)|²
     k
```

**Matrix Formulation:**
```
h = (F^T F)^(-1) F^T H_d
```

Where:
- `F` = Fourier matrix
- `H_d` = Desired frequency response
- `h` = Filter coefficients

#### 3. Weighted Least Squares

**Objective:** Minimize weighted squared error
```
min Σ w_k |H(ω_k) - H_d(ω_k)|²
     k
```

**Matrix Formulation:**
```
h = (F^T W F)^(-1) F^T W H_d
```

Where `W` = Diagonal weight matrix with different weights for:
- Passband frequencies
- Transition band
- Stopband frequencies

## 📊 GUI Overview

<div align="center">
  <img src="images/gui_1.png" alt="GUI View 1" width="29%"/>
  <img src="images/gui_2.png" alt="GUI View 2" width="29%"/>
  <img src="images/gui_3.png" alt="GUI View 3" width="29.6%"/>
</div>

*MATLAB App Designer GUI showing parameter controls and visualization options*

## 🎵 Audio Processing Pipeline

### Original and Upsampled Signals

<img src="images/original_spectrum.png" alt="Original Spectrum" width="400"/>

*Frequency spectrum of original audio signal (fs = 22050 Hz)*

<img src="images/upsampled_spectrum.png" alt="Upsampled Spectrum" width="400"/>

*Frequency spectrum after 2× upsampling (fs = 44100 Hz)*

### Interference Addition

<img src="images/interference_time_domain.png" alt="Time Domain Interference" width="400"/>

*Time domain: Audio signal (blue), Interference (red), Combined (green)*

**Interference Composition:**
```matlab
interferenceSignal = 
    1.0 × sin(2π × 5000 × t) +
    1.0 × cos(2π × 4000 × t) +
    1.0 × sin(2π × 6000 × t) +
    1.0 × cos(2π × 4500 × t) +
    1.0 × sin(2π × 5500 × t)
```

<img src="images/with_interference_spectrum.png" alt="Spectrum with Interference" width="400"/>

*Frequency spectrum showing high-frequency interference peaks (4-6 kHz range)*

## 🔧 Filter Design Results

### Windowed Sinc - Rectangular Window

<div align="center">
  <img src="images/windowed_sinc_rect/gui.png" alt="Rectangular GUI" width="32.83%"/>
  <img src="images/windowed_sinc_rect/filtered.png" alt="Rectangular Filtered" width="48%"/>
</div>

<div align="center">
  <img src="images/windowed_sinc_rect/linear.png" alt="Rectangular Linear" width="40.415%"/>
  <img src="images/windowed_sinc_rect/log.png" alt="Rectangular Log" width="40.415%"/>
</div>

*Rectangular window: Sharp cutoff, high sidelobes (-13 dB), fastest rolloff*

**Key Characteristics:**
- **Transition Width**: Narrowest
- **Stopband Attenuation**: -13 dB (poorest)
- **Ripple**: Gibb's phenomenon in passband
- **Complexity**: Lowest (multiplication by 1)

---

### Windowed Sinc - Blackman Window

<div align="center">
  <img src="images/windowed_sinc_blackman/gui.png" alt="Blackman GUI" width="32.83%"/>
  <img src="images/windowed_sinc_blackman/filtered.png" alt="Blackman Filtered" width="48%"/>
</div>

<div align="center">
  <img src="images/windowed_sinc_blackman/linear.png" alt="Blackman Linear" width="40.415%"/>
  <img src="images/windowed_sinc_blackman/log.png" alt="Blackman Log" width="40.415%"/>
</div>

*Blackman window: Smooth response, excellent sidelobe suppression (-58 dB)*

**Key Characteristics:**
- **Transition Width**: Wider than rectangular
- **Stopband Attenuation**: -58 dB (excellent)
- **Ripple**: Minimal passband ripple
- **Complexity**: Moderate

**⭐ Optimal Choice**: Best compromise between complexity and performance

---

### Windowed Sinc - Chebyshev Window

<div align="center">
  <img src="images/windowed_sinc_chebyshev/gui.png" alt="Chebyshev GUI" width="32.83%"/>
  <img src="images/windowed_sinc_chebyshev/filtered.png" alt="Chebyshev Filtered" width="48%"/>
</div>

<div align="center">
  <img src="images/windowed_sinc_chebyshev/linear.png" alt="Chebyshev Linear" width="40.415%"/>
  <img src="images/windowed_sinc_chebyshev/log.png" alt="Chebyshev Log" width="40.415%"/>
</div>

*Chebyshev window: Equiripple stopband, configurable attenuation (100 dB)*

**Key Characteristics:**
- **Transition Width**: Medium
- **Stopband Attenuation**: -100 dB (excellent, configurable)
- **Ripple**: Equiripple in stopband
- **Complexity**: High (requires Chebyshev polynomial computation)

---

### Windowed Sinc - Kaiser Window

<div align="center">
  <img src="images/windowed_sinc_kaiser/gui.png" alt="Kaiser GUI" width="32.83%"/>
  <img src="images/windowed_sinc_kaiser/filtered.png" alt="Kaiser Filtered" width="48%"/>
</div>

<div align="center">
  <img src="images/windowed_sinc_kaiser/linear.png" alt="Kaiser Linear" width="40.415%"/>
  <img src="images/windowed_sinc_kaiser/log.png" alt="Kaiser Log" width="40.415%"/>
</div>

*Kaiser window: Adjustable β parameter for trade-off control*

**Key Characteristics:**
- **Transition Width**: Adjustable via β
- **Stopband Attenuation**: Adjustable via β (used β = 5)
- **Ripple**: Smooth, controllable
- **Complexity**: Moderate (Bessel function computation)

---

### Least Squares Method

<div align="center">
  <img src="images/least_squares/gui.png" alt="LS GUI" width="32.83%"/>
  <img src="images/least_squares/filtered.png" alt="LS Filtered" width="48%"/>
</div>

<div align="center">
  <img src="images/least_squares/linear.png" alt="LS Linear" width="40.415%"/>
  <img src="images/least_squares/log.png" alt="LS Log" width="40.415%"/>
</div>

*Least Squares: Frequency-domain optimization with uniform error distribution*

**Key Characteristics:**
- **Optimization**: Minimizes squared error across all frequencies equally
- **Transition**: Gradual rolloff
- **Passband**: Smooth response
- **Stopband**: Moderate attenuation
- **Complexity**: High (matrix inversion required)

---

### Weighted Least Squares Method

<div align="center">
  <img src="images/weighted_least_squares/gui.png" alt="WLS GUI" width="32.83%"/>
  <img src="images/weighted_least_squares/filtered.png" alt="WLS Filtered" width="48%"/>
</div>

<div align="center">
  <img src="images/weighted_least_squares/linear.png" alt="WLS Linear" width="40.415%"/>
  <img src="images/weighted_least_squares/log.png" alt="WLS Log" width="40.415%"/>
</div>

*Weighted Least Squares: Prioritize stopband attenuation with weight control*

**Key Characteristics:**
- **Optimization**: Weighted error minimization
- **Weight Distribution**:
  - Passband (ω ≤ ωc - 0.1): w_pass
  - Transition (ωc - 0.1 < ω ≤ ωc + 0.1): w_trans
  - Stopband (ω > ωc + 0.1): w_stop
- **Flexibility**: Adjustable emphasis on different bands
- **Complexity**: Highest (weighted matrix operations)

---

## 🚀 Getting Started

### Prerequisites

**MATLAB Requirements:**
```
MATLAB R2020a or later
Signal Processing Toolbox
MATLAB App Designer
Audio Toolbox (for audioread/audiowrite)
```

### Installation

1. **Clone the repository**
```bash
git clone https://github.com/yourusername/dsp-filter-design-tool.git
cd dsp-filter-design-tool
```

2. **Open MATLAB**
```matlab
cd 'path/to/dsp-filter-design-tool/DSP_Filter_Final/matlap'
```

3. **Run the GUI**
```matlab
Filter_Tool  % Opens the App Designer interface
```

## 📖 Usage Guide

### Using the GUI

1. **Launch Application:**
```matlab
   Filter_Tool
```

2. **Select Method:**
   - Choose filter design method from dropdown
   - Options: Windowed sinc, LS, WLC

3. **Configure Parameters:**
   - **Filter Length**: Odd number (e.g., 51, 101, 201)
   - **Cutoff Frequency**: Normalized (0 to π) or Hz
   - **Window Type**: (for Windowed Sinc only)
     - Rectangular, Blackman, Chebyshev, Kaiser
   - **Desired Points**: Number of frequency samples (for LS/WLS)
   - **Weights**: [w_pass, w_trans, w_stop] (for WLS only)
   - **Scale**: Linear or Log

4. **Generate Filter:**
   - Click "Design Filter" button
   - View magnitude response plots
   - Observe filter coefficients

5. **Apply to Audio:**
   - Filter is automatically applied to loaded audio
   - Triple filtering for enhanced noise reduction
   - Listen to filtered output

### Command-Line Usage
```matlab
% Design filter
length = 101;
Desired_Points = 1000;
cutoff = 0.3 * pi;  % Normalized
weights = [1, 0.5, 10];  % [passband, transition, stopband]

% Windowed Sinc method
Filter = WindowedSync(length, 'Blackman', cutoff, 'Linear Scale');

% Least Squares method
Filter = LC(length, Desired_Points, cutoff, 'Log Scale');

% Weighted Least Squares method
Filter = WLC(length, Desired_Points, cutoff, weights, 'Linear Scale');

% Apply filter
filteredSignal = filter(Filter, 1, audioWithInterference);
filteredSignal = filter(Filter, 1, filteredSignal);  % Second pass
filteredSignal = filter(Filter, 1, filteredSignal);  % Third pass
```

## 🎓 Learning Outcomes

This project demonstrates:

1. **FIR Filter Design**: Three different design methodologies
2. **Window Functions**: Impact on frequency response
3. **Frequency-Domain Design**: Least squares optimization
4. **Trade-offs**: Complexity vs. performance analysis
5. **Audio Signal Processing**: Practical noise removal
6. **MATLAB Programming**: GUI development, signal processing
7. **Filter Analysis**: Linear vs. logarithmic visualization

## 🔬 Design Decisions

### Optimal Filter Selection

**For this application (audio interference removal), the Blackman-windowed Sinc filter was chosen as optimal because:**

1. **Sufficient Attenuation**: -58 dB stopband attenuation effectively removes interference
2. **Low Complexity**: Simple windowing operation vs. matrix computations
3. **Smooth Response**: Minimal passband ripple preserves audio quality
4. **Computational Efficiency**: Fast coefficient generation and runtime filtering
5. **No Artifacts**: Smooth magnitude response avoids audible distortion

### Multi-Stage Filtering

**Why triple filtering?**
```matlab
filteredSignal = filter(Filter, 1, audioWithInterference);
filteredSignal = filter(Filter, 1, filteredSignal);
filteredSignal = filter(Filter, 1, filteredSignal);
```

- **Cascade Effect**: Each stage provides additional attenuation
- **Effective Order**: Triples the filter order (3 × -58 dB = -174 dB theoretical)
- **Steeper Rolloff**: Sharper transition band
- **Better Noise Removal**: Enhanced stopband rejection

## 🤝 Contributing

Contributions are welcome! Feel free to:

- Add new window functions
- Implement IIR filter designs
- Enhance GUI features
- Add more filter design methods
- Improve visualization options
- Add real-time audio processing

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🙏 Acknowledgments

- Course: CIE 442 - Digital Signal Processing
- Department: Communications and Information Engineering
- MATLAB Signal Processing Toolbox
- Digital filter design theory

<br>
<div align="center">
  <a href="https://codeload.github.com/TendoPain18/dsp-filter-design-tool/legacy.zip/main">
    <img src="https://img.shields.io/badge/Download-Files-brightgreen?style=for-the-badge&logo=download&logoColor=white" alt="Download Files" style="height: 50px;"/>
  </a>
</div>

## <!-- CONTACT -->
<div id="toc" align="center">
  <ul style="list-style: none">
    <summary>
      <h2 align="center">
        🚀
        CONTACT ME
        🚀
      </h2>
    </summary>
  </ul>
</div>
<table align="center" style="width: 100%; max-width: 600px;">
<tr>
  <td style="width: 20%; text-align: center;">
    <a href="https://www.linkedin.com/in/amr-ashraf-86457134a/" target="_blank">
      <img src="https://img.shields.io/badge/LinkedIn-0077B5?style=for-the-badge&logo=linkedin&logoColor=white" style="height: 33px; width: 120px;"/>
    </a>
  </td>
  <td style="width: 20%; text-align: center;">
    <a href="https://github.com/TendoPain18" target="_blank">
      <img src="https://img.shields.io/badge/GitHub-100000?style=for-the-badge&logo=github&logoColor=white" style="height: 33px; width: 120px;"/>
    </a>
  </td>
  <td style="width: 20%; text-align: center;">
    <a href="mailto:amrgadalla01@gmail.com">
      <img src="https://img.shields.io/badge/Gmail-D14836?style=for-the-badge&logo=gmail&logoColor=white" style="height: 33px; width: 120px;"/>
    </a>
  </td>
  <td style="width: 20%; text-align: center;">
    <a href="https://www.facebook.com/amr.ashraf.7311/" target="_blank">
      <img src="https://img.shields.io/badge/Facebook-1877F2?style=for-the-badge&logo=facebook&logoColor=white" style="height: 33px; width: 120px;"/>
    </a>
  </td>
  <td style="width: 20%; text-align: center;">
    <a href="https://wa.me/201019702121" target="_blank">
      <img src="https://img.shields.io/badge/WhatsApp-25D366?style=for-the-badge&logo=whatsapp&logoColor=white" style="height: 33px; width: 120px;"/>
    </a>
  </td>
</tr>
</table>
<!-- END CONTACT -->

## **Design, analyze, and perfect your digital filters! 🎵✨**

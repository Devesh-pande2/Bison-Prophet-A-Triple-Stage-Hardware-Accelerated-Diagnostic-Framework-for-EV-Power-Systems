Bison-Prophet: A Triple-Stage Hardware-Accelerated Diagnostic Framework for EV Power Systems
⚡ The "Spike Prophecy" Ecosystem
This project presents an advanced Prognostic Health Management (PHM) system designed to predict high-voltage transients (spikes) in EV charging infrastructure. By bridging the gap between MATLAB-trained AI and high-speed hardware gateways, the system identifies potential failures before they occur.

🛠️ Project Architecture
The framework is divided into three distinct stages of development:

Stage 1: Simulink Plant Simulator

Generates high-fidelity voltage patterns for Low and Medium voltage stages.

Key Files: triping.slx, plant.slx, evs.slx.

Stage 2: FPGA-Ready Diagnostic Gateway

Provides real-time threshold control and a path for high-speed hardware protection.

Prepared for Verilog code generation to ensure sub-millisecond response times.

Stage 3: Bayesian Intelligence Layer

Uses a MATLAB-trained Bayesian Network for Root Cause Analysis (RCA).

Identifies specific failing components, such as Capacitor Banks or MOSFETs.

Key Files: bison_logic.m, BisonBrain_Optimized.mat.

📈 Key Outputs & Results
Root Cause Analysis (RCA): The model performs diagnostic reasoning to isolate hardware faults based on 40V failure patterns.

Predictive Alerting: Provides a "Spike Prophecy," issuing a warning before critical voltage thresholds are reached.

Interactive Dashboard: A custom Python-integrated dashboard for real-time visualization of the EV power system's health.

📑 Documentation & Research
R&D Paper: For a deep dive into the mathematical formulations and simulation methodology, refer to the Research Paper in the Documentation/ folder.

Datasets: The final training data is available in final_parameters_data.csv.

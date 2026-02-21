% InnoTech 2026: Ultra-Realistic Pattern Generator
% Features: 15-Sample Buffer, Thermal Stress, and Stochastic Jitter
model_name = 'evs'; 
num_patterns = 10; 
samples_per_pattern = 15; 
total_runs = num_patterns * samples_per_pattern;
dataset = zeros(total_runs, 7); 

load_system(model_name);
set_param(model_name, 'FastRestart', 'on');

% --- JITTER FUNCTION ---
% This simulates +/- 1% sensor noise/fluctuation
jitter = @(val) val * (1 + (rand - 0.5) * 0.02); 

current_heat = 35.0; 
row = 1;

for p = 1:num_patterns
    pattern_type = randi([1, 3]); 
    for s = 1:samples_per_pattern
        % Pattern Logic (Silent THD, Voltage Stress, or Thermal Overload)
        if pattern_type == 1 % Silent THD
            V_s = 1; I_s = 1; N_s = (s/samples_per_pattern) * 3;
        elseif pattern_type == 2 % Voltage-Harmonic
            V_s = (s/samples_per_pattern) * 3; I_s = 1; N_s = V_s;
        else % Thermal Overload
            V_s = 2; I_s = (s/samples_per_pattern) * 3; N_s = I_s;
        end

        assignin('base', 'Voltage_scenario', max(1, round(V_s))); 
        assignin('base', 'noise_scenario', max(1, round(N_s))); 
        assignin('base', 'current_scenario', max(1, round(I_s))); 
        
        simOut = sim(model_name, 'StopTime', '0.5');
        
        % STEP 1: Extract Raw Data
        raw_V = real(double(simOut.simout.Data(end)));      
        raw_T = real(double(simOut.simout1.Data(end)));   
        raw_I = real(double(simOut.simout2.Data(end)));     
        
        % STEP 2: Apply the "Ultra Realistic" Jitter Probe
        V_val = jitter(raw_V);
        T_val = jitter(raw_T);
        I_val = jitter(raw_I);
        current_heat = jitter(current_heat); % Temperature also jitters slightly

        % Heat accumulation logic remains the same
        heat_gain = (V_val * I_val * T_val) / 200; 
        current_heat = current_heat + heat_gain - 0.05; 
        current_heat = max(35, min(110, current_heat)); 

        dataset(row, :) = [V_val, I_val, T_val, current_heat, V_s, N_s, I_s];
        row = row + 1;
    end
end

set_param(model_name, 'FastRestart', 'off');
writematrix(dataset, 'evs_ultra_realistic_patterns.csv');
disp('SUCCESS: Generated 150 jittered samples for robust AI training.');
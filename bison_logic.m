function out_vector = bison_logic(u)
    v = u(1); i = u(2); thd = u(3); temp = u(4); clk = u(5);
    persistent model last_v last_clk label_buffer;
    
    if isempty(model)
        data = load('BisonBrain_Optimized.mat'); %
        model = data.trainedBisonModel;
        last_v = v; last_clk = clk;
        label_buffer = ones(1, 200); % 10-second window
    end

    dt = max(1e-6, clk - last_clk);
    dVdt = (v - last_v) / dt;

    [lbl_cat, scores] = predict(model, [v, i, thd, temp, dVdt, 0]);
    current_label = double(lbl_cat);
    
    % Averaging Logic: 10-second Mode Filter
    label_buffer = [label_buffer(2:end), current_label];
    avg_label = mode(label_buffer);
    
    % Health Scoring (100% means healthy, lower means danger)
    % We use the probability of the healthy class (Index 1)
    health_score = double(scores(1)) * 100;
    
    % Prophecy Logic with clean zero-out for healthy systems
    if avg_label >= 2 && dVdt > 0.001
        tte = max(0, (33 - v) / dVdt);
    else
        tte = 0; % No lead time if healthy
    end
    
    % Final output vector
    out_vector = [double(avg_label); health_score; double(tte); double(avg_label)];
    last_v = v; last_clk = clk;
end
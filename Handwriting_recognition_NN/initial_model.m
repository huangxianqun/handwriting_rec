function ret = initial_model(n_hid)
    % 模型初始化
    n_params = (256+10) * n_hid;
    as_row_vector = cos(0:(n_params-1));
    ret = theta_to_model(as_row_vector(:) * 0.1); % 可以考虑换成随机初始化
end
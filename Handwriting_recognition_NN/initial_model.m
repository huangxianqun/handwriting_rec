function ret = initial_model(n_hid)
    % ģ�ͳ�ʼ��
    n_params = (256+10) * n_hid;
    as_row_vector = cos(0:(n_params-1));
    ret = theta_to_model(as_row_vector(:) * 0.1); % ���Կ��ǻ��������ʼ��
end
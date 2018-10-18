%%
clear;clc;close all;

% ���Գ����޸ĵĲ��������ڼ�����⣬��ø��ŵ����ܡ�
n_hid =35;                 % ������Ԫ����
n_iters = 8000;              % ��������
learning_rate = 0.46;       % ѧϰ��
mini_batch_size = 1;      % batch��С
%22 3000 0.45
% ��ʼ��
if exist('page_output_immediately')
    page_output_immediately(1); 
end
more off;
model = initial_model(n_hid);
load('data/train.mat');
train.targets(:,4001:end)=[];
train.inputs(:,4001:end)=[];
training = train;
n_training_cases = size(training.inputs, 2);
if n_iters ~= 0,
    test_gradient(model, training); 
end

% ѵ��
theta = model_to_theta(model);  % ��ģ��ת�������������ڼ��㡣
momentum_speed = theta * 0;     % ʵ���ݶ��½���ֵ
training_data_losses = [];      % ѵ�����ϵ����
for optimization_iteration_i = 1:n_iters,
    model = theta_to_model(theta);

    training_batch_start = mod((optimization_iteration_i-1) * mini_batch_size, n_training_cases)+1;
    training_batch.inputs = training.inputs(:, training_batch_start : training_batch_start + mini_batch_size - 1);
    training_batch.targets = training.targets(:, training_batch_start : training_batch_start + mini_batch_size - 1);
    gradient = model_to_theta(d_loss_by_d_model(model, training_batch));
    
    theta = theta - learning_rate * gradient;     % ����Ȩֵ

    model = theta_to_model(theta);
    training_data_losses = [training_data_losses, loss(model, training)];
    if mod(optimization_iteration_i, round(n_iters/10)) == 0,
        fprintf('After %d optimization iterations, training data loss is %f\n', optimization_iteration_i, training_data_losses(end));
    end
end

if n_iters ~= 0,
    test_gradient(model, training);
end

model = theta_to_model(theta);
if n_iters ~= 0,
clf;
hold on;
plot(training_data_losses, 'b');
legend('training');
ylabel('loss');
xlabel('iteration number');
hold off;
end
save model.mat model;

%% ���Է���Ч��
load('data/train.mat');
training = train;
load('data/test.mat');
testing = test;
load('model.mat');
datas2 = {training, testing};
data_names = {'training', 'test'};
for data_i = 1:2,
    data = datas2{data_i};
    data_name = data_names{data_i};
    fprintf('\nThe loss on the %s data is %f\n', data_name, loss(model, data));
    fprintf('The classification sucess rate on the %s data is %.2f%%\n', data_name, 100-100*classification_performance(model, data));
end



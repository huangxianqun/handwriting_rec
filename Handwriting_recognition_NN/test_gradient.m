function test_gradient(model, data)
    base_theta = model_to_theta(model);
    h = 1e-2;
    correctness_threshold = 1e-5;
    analytic_gradient = model_to_theta(d_loss_by_d_model(model, data));
    % Test the gradient not for every element of theta, because that's a lot of work. Test for only a few elements.
    for i = 1:100,
        test_index = mod(i * 1299721, size(base_theta,1)) + 1; % 1299721 is prime and thus ensures a somewhat random-like selection of indices
        analytic_here = analytic_gradient(test_index);
        theta_step = base_theta * 0;
        theta_step(test_index) = h;
        contribution_distances = [-4:-1, 1:4];
        contribution_weights = [1/280, -4/105, 1/5, -4/5, 4/5, -1/5, 4/105, -1/280];
        temp = 0;
        for contribution_index = 1:8,
            temp = temp + loss(theta_to_model(base_theta + theta_step * contribution_distances(contribution_index)), data) * contribution_weights(contribution_index);
        end
        fd_here = temp / h;
        diff = abs(analytic_here - fd_here);
        % fprintf('%d %e %e %e %e\n', test_index, base_theta(test_index), diff, fd_here, analytic_here);
        if diff < correctness_threshold, 
            continue; 
        end
        if diff / (abs(analytic_here) + abs(fd_here)) < correctness_threshold, 
            continue;
        end
        error(sprintf('Theta element #%d, with value %e, has finite difference gradient %e but analytic gradient %e. That looks like an error.\n', test_index, base_theta(test_index), fd_here, analytic_here));
    end
    fprintf('Gradient test passed. That means that the gradient that your code computed is within 0.001%% of the gradient that the finite difference approximation computed, so the gradient calculation procedure is probably correct (not certainly, but probably).\n');
end
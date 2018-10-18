function ret = logistic(input)
    % Your code here
    % Âß¼­Éñ¾­Ôª logistic neuron
    ret = input;
    for i=1:size(ret,1)
        for j=1:size(ret,2)
        ret(i,j)=1/(1+exp(-1*input(i,j)));
    end
    
    
end
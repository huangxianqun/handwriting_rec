function ret = loss(model, data)
    % model.input_to_hid is a matrix of size <number of hidden units> by <number of inputs i.e. 256>
    % model.hid_to_class is a matrix of size <number of classes i.e. 10> by <number of hidden units>
    % data.inputs is a matrix of size <number of inputs i.e. 256> by <number of data cases>. Each column describes a different data case. 
    % data.targets is a matrix of size <number of classes i.e. 10> by <number of data cases>. Each column describes a different data case. It contains a one-of-N encoding of the class, i.e. one element in every column is 1 and the others are 0.
    % mean cross-entropy loss.
    % Your code here.    
    
    % 先正向传播求取网络输出(softmax)；
    %隐层神经元的输入
    hid=model.input_to_hid*data.inputs;
    %隐层神经元输出
    hid_out=logistic(hid);
    %输出神经元输入
    outputs=model.hid_to_class*hid_out;
    %输出神经元输出
    for i=1:size(outputs,1)
        for j=1:size(outputs,2)
            esi_total=0;
            for k=1:size(outputs,1)
                esi_total=esi_total+exp(outputs(k,j));
            end
            outputs_out(i,j)=exp(outputs(i,j))/esi_total;
        end
    end
            
    % 计算cross-entropy
    ek=zeros(1,size(data.targets,2));
    for i=1:size(data.targets,2)
        for j=1:size(data.targets,1)
            ek(1,i)=ek(1,i)-1*(data.targets(j,i)*log(outputs_out(j,i)));
        end
    end
   ret=mean(ek);
end
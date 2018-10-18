function ret = d_loss_by_d_model(model, data)
    % 计算梯度
    % model.input_to_hid is a matrix of size <number of hidden units> by <number of inputs i.e. 256>
    % model.hid_to_class is a matrix of size <number of classes i.e. 10> by <number of hidden units>
    % data.inputs is a matrix of size <number of inputs i.e. 256> by <number of data cases>. Each column describes a different data case. 
    % data.targets is a matrix of size <number of classes i.e. 10> by <number of data cases>. Each column describes a different data case. It contains a one-of-N encoding of the class, i.e. one element in every column is 1 and the others are 0.
    hid_to_class=model.hid_to_class;
    % Your code here.   
    % 先正向传播求取网络输出；
    %隐层神经元的输入
    hid=model.input_to_hid*data.inputs;
    %隐层神经元输出
    hid_out=logistic(hid);
    %输出神经元输入
    outputs=model.hid_to_class*hid_out;
    %输出神经元输出
    outputs=exp(outputs);
    for i=1:size(outputs,2)
            outputs_out(:,i)=outputs(:,i)/sum(outputs(:,i));
    end
    % 再根据网络输出求梯度
    % ret的结构与model相同，但是每一位储存的是每个权值的梯度。
    ret.hid_to_class = model.hid_to_class * 0;  % 隐层到输出层之间权值的梯度
    ret.input_to_hid = model.input_to_hid * 0;  % 输入层到隐层之间权值的梯度
    
    %首先计算隐层到输出层之间权值的梯度
  % for i=1:size(data.inputs,2)%样本个数
      % ret.hid_to_class=ret.hid_to_class+(outputs_out(:,i)-data.targets(:,i))*hid_out(:,i)';
      % for j=1:size(ret.input_to_hid)
          % add_ith(j,:)=(hid_out(j,i)*(1-hid_out(j,i))*model.hid_to_class(:,j)'*(outputs_out(:,i)-data.targets(:,i))*data.inputs(:,i)');
     %  end
       %ret.input_to_hid=ret.input_to_hid+add_ith;
   %end
   for num=1:size(data.inputs,2)
        for i=1:size(ret.hid_to_class,1) 
            for j=1:size(ret.hid_to_class,2)
               ret.hid_to_class(i,j)=ret.hid_to_class(i,j)+hid_out(j,num)*(outputs_out(i,num)-data.targets(i,num));
            end
        end
   end
  
   %再计算输入层到隐层之间权值的梯度
   for num=1:size(data.inputs,2)
       for k=1:size(data.inputs,1)
           for j=1:size(model.input_to_hid,1)
               e_kj=0;
               for i=1:size(data.targets,1)
                  e_kj=e_kj+(outputs_out(i,num)-data.targets(i,num))*model.hid_to_class(i,j)*(hid_out(j,num)*(1-hid_out(j,num)))*data.inputs(k,num);
               end
                ret.input_to_hid(j,k)=ret.input_to_hid(j,k)+e_kj;
           end
       end
   end
    ret.hid_to_class=ret.hid_to_class/size(data.inputs,2);
    ret.input_to_hid=ret.input_to_hid/size(data.inputs,2);
    
    
end



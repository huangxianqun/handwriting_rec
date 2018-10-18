function ret = loss(model, data)
    % mean cross-entropy loss.
    % Your code here.    
    
    xpn=data.inputs; %训练数据集
    xln=data.targets; %数据标签
    wih=model.input_to_hid; %从输入到隐藏层的权重矩阵
    whc=model.hid_to_class; %从隐藏层到输出层的权重矩阵
    
    % 先正向传播求取网络输出(softmax)；
    sj=wih*xpn;
    xj=1./(1+exp(-sj));
    si=whc*xj;
    esi=exp(si);
    for i=1:length(esi)
        xi(:,i)=esi(:,i)/sum(esi(:,i));
    end    
    
    % 计算cross-entropy
    for i=1:length(xi)
        E(i)=-xln(:,i)'*log(xi(:,i));
    end     
    
    %返回平均误差E
    ret = mean(E);
end
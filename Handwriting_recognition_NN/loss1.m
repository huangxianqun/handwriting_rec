function ret = loss(model, data)
    % mean cross-entropy loss.
    % Your code here.    
    
    xpn=data.inputs; %ѵ�����ݼ�
    xln=data.targets; %���ݱ�ǩ
    wih=model.input_to_hid; %�����뵽���ز��Ȩ�ؾ���
    whc=model.hid_to_class; %�����ز㵽������Ȩ�ؾ���
    
    % �����򴫲���ȡ�������(softmax)��
    sj=wih*xpn;
    xj=1./(1+exp(-sj));
    si=whc*xj;
    esi=exp(si);
    for i=1:length(esi)
        xi(:,i)=esi(:,i)/sum(esi(:,i));
    end    
    
    % ����cross-entropy
    for i=1:length(xi)
        E(i)=-xln(:,i)'*log(xi(:,i));
    end     
    
    %����ƽ�����E
    ret = mean(E);
end
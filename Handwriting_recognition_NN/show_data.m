function show_data(n)
    % ���ݿ��ӻ�
    % ����n,��ʾѵ�����ݵĵ�n��ͼƬ���ǩ
    close all;

    % ��ȡ����
    load train.mat

    % Your code here
    % ��ȡ�����������
    image_vector=train.inputs(:,n);
    image_sign=train.targets(:,n);
    % ������ת����16x16����ͼƬ��
    image=zeros(16,16);
    for i=1:16
        for j=1:16
            image(i,j)=image_vector((i-1)*16+j,1);
        end
    end     
    %��ȡ��ǩ
    for i=1:size(image_sign)
        if image_sign(i,1)==0
            continue;
        else
            image_label=i-1;
        end
    end
    % �Ŵ�ʮ��   
    image = imresize(image,10)
    % ��ʾͼƬ
    imshow(image);
    title(['label:',num2str(image_label)]);
end
    


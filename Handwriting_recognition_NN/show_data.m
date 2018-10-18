function show_data(n)
    % 数据可视化
    % 输入n,显示训练数据的第n张图片与标签
    close all;

    % 读取数据
    load train.mat

    % Your code here
    % 读取输入输出向量
    image_vector=train.inputs(:,n);
    image_sign=train.targets(:,n);
    % 将向量转换成16x16矩阵（图片）
    image=zeros(16,16);
    for i=1:16
        for j=1:16
            image(i,j)=image_vector((i-1)*16+j,1);
        end
    end     
    %获取标签
    for i=1:size(image_sign)
        if image_sign(i,1)==0
            continue;
        else
            image_label=i-1;
        end
    end
    % 放大十倍   
    image = imresize(image,10)
    % 显示图片
    imshow(image);
    title(['label:',num2str(image_label)]);
end
    


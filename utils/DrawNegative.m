function wimgs = DrawNegative( frame, affine, params )
%%%%

%%
sz = params.template_sz;
n = params.nneg;

%% �õ�neg_num����ģ��
affines = repmat( affine(:), 1, n);%��ʼ�����и������ķ������

affmat = affparam2mat( affine );
sigma = [ round( sz(2)*affmat(3) ) , round( sz(1)*affmat(3)*affine(5) ) , 0.0, 0.0, 0.0, 0.0];
affines = affines + randn(6,n).*repmat( sigma(:), 1, n);%�����еķ����������Ŷ�

% ������и�������Ŀ�����ĵľ����Ƿ����һ����ֵ
%--���x����
dist = round( sigma(1)/4 );%������λ�õĺ�������룬��������������λ�õĺ��������Ҫ���ڸ�ֵ��
center = affine(1);%����λ�õĺ�����
left = center - dist;%��߽�
right = center + dist;%�ұ߽�
id = affines(1,:)<=right & affines(1,:)>=center ;
affines(1,id) = right;
id = affines(1,:)>=left & affines(1,:)<center;
affines(1,id) = left;

%--���y����
dist = round( sigma(2)/4 );
center = affine(2);
top = center - dist;%�ϱ߽�
bottom = center + dist;%�±߽�
id = affines( 2,: )>=top & affines( 2,: )<center;
affines(2,id) = top;
id = affines(2,:)<=bottom & affines(2,:)>=center;
affines(2,id) = bottom;

affmats = affparam2mat( affines );%�����еķ����������ת�����õ�ת����ķ������
wimgs = warpimg( frame, affmats, sz );%��������������õ������ķ���ͼ

end
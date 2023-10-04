%%%%%%%%%%%%%%%%%%% �������� %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

n = 2000;                % ��������С
X = rand(n,2)*9;        % n * 2�����ݾ���ÿһ�б�ʾһ�����ݵ㣬��һ�б�ʾx�����꣬�ڶ��б�ʾy������
Y = zeros(n,1);          % ����ǩ

alpha = 0;
for i=1:n
   if 0<X(i,1) && X(i,1)<3 && 0<X(i,2) && X(i,2)<3              % ����x��y������ȷ������      
       Y(i) = 1;
   end
   if 0<X(i,1) && X(i,1)<3 && 3+alpha<X(i,2) && X(i,2)<6+alpha
       Y(i) = 2;
   end
   if 0<X(i,1) && X(i,1)<3 && 6+2*alpha<X(i,2) && X(i,2)<9+2*alpha
       Y(i) = 3;
   end
   if 3+alpha<X(i,1) && X(i,1)<6+alpha && 0<X(i,2) && X(i,2)<3
       Y(i) = 4;
   end
   if 3+alpha<X(i,1) && X(i,1)<6+alpha && 3+alpha<X(i,2) && X(i,2)<6+alpha
       Y(i) = 5;
   end
   if 3+alpha<X(i,1) && X(i,1)<6+alpha && 6+2*alpha<X(i,2) && X(i,2)<9+2*alpha
       Y(i) = 6;
   end
   if 6+2*alpha<X(i,1) && X(i,1)<9+2*alpha && 0<X(i,2) && X(i,2)<3
       Y(i) = 7;
   end
   if 6+2*alpha<X(i,1) && X(i,1)<9+2*alpha && 3+alpha<X(i,2) && X(i,2)<6+alpha
       Y(i) = 8;
   end;
   if 6+2*alpha<X(i,1) && X(i,1)<9+2*alpha && 6+2*alpha<X(i,2) && X(i,2)<9+2*alpha
       Y(i) = 9;
   end;
end
X = X(Y>0,:);                                                    % ע��X����[0,10]*[0,10]��Χ�ھ������ɵģ�������ֻ�����һ����X�����֮��İ�ɫ����еĵ�û�б꣬�����Ҫ����Щ��ȥ��
Y = Y(Y>0,:);                                                    % X(Y>0,:)��ʾֻȡX�ж�Ӧ��Y����0���У�������Ϊ��ɫ����еĵ��Y��Ϊ0
n = length(Y);                                                   % ȥ������ɫ���ʣ�µĵ�ĸ���

figure(1)
set (gcf,'Position',[1,1,700,600], 'color','w')
set(gca,'Fontsize',18)
plot(X(Y==1,1),X(Y==1,2),'ro','LineWidth',1,'MarkerSize',10);            % ����һ�����ݵ�
hold on;
plot(X(Y==2,1),X(Y==2,2),'ko','LineWidth',1,'MarkerSize',10);            % ���ڶ������ݵ�
hold on;
plot(X(Y==3,1),X(Y==3,2),'bo','LineWidth',1,'MarkerSize',10);            % �����������ݵ�
hold on;
plot(X(Y==4,1),X(Y==4,2),'g*','LineWidth',1,'MarkerSize',10);            % �����������ݵ�
hold on;
plot(X(Y==5,1),X(Y==5,2),'m*','LineWidth',1,'MarkerSize',10);            % �����������ݵ�
hold on;
plot(X(Y==6,1),X(Y==6,2),'c*','LineWidth',1,'MarkerSize',10);            % �����������ݵ�
hold on;
plot(X(Y==7,1),X(Y==7,2),'b+','LineWidth',1,'MarkerSize',10);            % �����������ݵ�
hold on;
plot(X(Y==8,1),X(Y==8,2),'r+','LineWidth',1,'MarkerSize',10);            % ���ڰ������ݵ�
hold on;
plot(X(Y==9,1),X(Y==9,2),'k+','LineWidth',1,'MarkerSize',10);            % ���ھ������ݵ�
hold on;
hold on;
xlabel('x axis');
ylabel('y axis');

clear Y;                                                                 % �����Ϣ��������������

%%%%%%%%%%%%%%%%%%  K-means�㷨��ѧ��ʵ��     %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%  ������������ע�������ϢY�ǲ���ʹ�õ�     %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

K = 9;                                 % ���ĵ����
Ym = zeros(n,1);                       % ÿ�����ݵ��Ԥ��������
meanpoint = rand(K,2)*10; % K����ʼ����
h=55;
Xdis=zeros(n,9);%�����洢n���������9���������ĵľ���
llq=0;  %��������������ĵ�����˶��ٴ�


for u=1:1:350 %���õ�����������
for i=1:1:n
for j=1:1:9
Xdis(i,j)=(X(i,1)-meanpoint(j,1))^h+(X(i,2)-meanpoint(j,2))^h;%�����������
Xdis(i,j)=Xdis(i,j)^(1/h);%%ͨ���ı�h��ֵ��ȡ�ò�ͬ�ľ����������
end
[P,Ym(i,1)]=min(Xdis(i,:)); 

for j=1:1:9 %��9���������������и���
sum1=0.001;
sum2=0.001;
sumx1=0;
sumx2=0;
for p=1:1:n  

if Ym(p,1)==j      
    sumx1=sumx1+X(p,1);
    sum1=sum1+1;
   sumx2=sumx2+X(p,2);
    sum2=sum2+1;
end
end          


if (meanpoint(j,1)~=sumx1/sum1)||(meanpoint(j,2)~=sumx2/sum2)
meanpoint(j,1)=sumx1/sum1;
meanpoint(j,2)=sumx2/sum2;
llq=llq+1;  %���һ����������������������������һ
else 
 break  %%������ֲ��ٸı䣬������ѭ�� 
end
end     
end
end





%%%%%%%%%%%%%%%%%%  ���������������ĵ�     %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

figure(2)
set (gcf,'Position',[1,1,700,600], 'color','w')
set(gca,'Fontsize',18)
plot(X(Ym==1,1),X(Ym==1,2),'ro','LineWidth',1,'MarkerSize',10);            % ����һ�����ݵ�
hold on;
plot(X(Ym==2,1),X(Ym==2,2),'ko','LineWidth',1,'MarkerSize',10);            % ���ڶ������ݵ�
hold on;
plot(X(Ym==3,1),X(Ym==3,2),'bo','LineWidth',1,'MarkerSize',10);            % �����������ݵ�
hold on;
plot(X(Ym==4,1),X(Ym==4,2),'g*','LineWidth',1,'MarkerSize',10);            % �����������ݵ�
hold on;
plot(X(Ym==5,1),X(Ym==5,2),'m*','LineWidth',1,'MarkerSize',10);            % �����������ݵ�
hold on;
plot(X(Ym==6,1),X(Ym==6,2),'c*','LineWidth',1,'MarkerSize',10);            % �����������ݵ�
hold on;
plot(X(Ym==7,1),X(Ym==7,2),'b+','LineWidth',1,'MarkerSize',10);            % �����������ݵ�
hold on;
plot(X(Ym==8,1),X(Ym==8,2),'r+','LineWidth',1,'MarkerSize',10);            % ���ڰ������ݵ�
hold on;
plot(X(Ym==9,1),X(Ym==9,2),'k+','LineWidth',1,'MarkerSize',10);            % ���ھ������ݵ�
hold on;
plot(meanpoint(:,1),meanpoint(:,2),'ms','MarkerFaceColor','m','LineWidth',1,'MarkerSize',10);    % �������ĵ�
hold on;
xlabel('x axis');
ylabel('y axis');
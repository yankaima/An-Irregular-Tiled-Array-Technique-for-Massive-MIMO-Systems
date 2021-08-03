function [H,H2,Fopt,Wopt]=channel_realization(Ns,Nt,Nr,realization,angle_sigma,AoD_m_thetamin,AoD_mthetamax,AoA_m_thetamin,AoA_mthetamax,patternrE,Zr,Zt_64,Zt_32)

H=zeros(Nr,Nt,realization);
H2=zeros(Nr/2,Nt,realization);
Fopt=zeros(Nt,Ns,realization);
Wopt=zeros(Nr,Nr,realization);

cc = 3e8;
fc = 28e9;
lambda = cc/fc;
txarray =phased.URA([sqrt(Nt) sqrt(Nt)],lambda/2);
rxarray = phased.URA([sqrt(Nr) sqrt(Nr)],lambda/2);
txpos = getElementPosition(txarray)/lambda;
rxpos = getElementPosition(rxarray)/lambda;
txpos=[txpos(2,:);txpos(3,:);txpos(1,:)];
rxpos=[rxpos(2,:);rxpos(3,:);rxpos(1,:)];
Nc = 8; % # of clusters
Nray =10; % # of rays in each cluster

sigma = 1;
alpha=zeros(1,Nc*Nray);

for reali = 1:realization
%         txang = [rand(1,Nscatter)*180-90;rand(1,Nscatter)*180-90];
%         rxang = [rand(1,Nscatter)*180-90;rand(1,Nscatter)*180-90];
%         g = (randn(1,Nscatter)+1i*randn(1,Nscatter))/sqrt(Nscatter)/sqrt(2);
    for c = 1:Nc
        AoD_m = [unifrnd(-pi,pi,1,1);unifrnd(AoD_m_thetamin,AoD_mthetamax,1,1)];%%%[phi;theta]
        AoA_m = [unifrnd(-pi,pi,1,1);unifrnd(AoA_m_thetamin,AoA_mthetamax,1,1)];
        AoD(1,[(c-1)*Nray+1:Nray*c]) = laprnd(1,Nray,AoD_m(1),angle_sigma);
        AoD(2,[(c-1)*Nray+1:Nray*c]) = laprnd(1,Nray,AoD_m(2),angle_sigma);
        AoA(1,[(c-1)*Nray+1:Nray*c]) = laprnd(1,Nray,AoA_m(1),angle_sigma);
        AoA(2,[(c-1)*Nray+1:Nray*c]) = laprnd(1,Nray,AoA_m(2),angle_sigma);
    end
    AoA=AoA*180/pi;
    AoD=AoD*180/pi;
    AoD(1,AoD(1,:)>180)=AoD(1,AoD(1,:)>180)-180;
    AoD(1,AoD(1,:)<-180)=AoD(1,AoD(1,:)<-180)+180;
    AoA(1,AoA(1,:)>180)=AoA(1,AoA(1,:)>180)-180;
    AoA(1,AoA(1,:)<-180)=AoA(1,AoA(1,:)<-180)+180;
    AoD(2,AoD(2,:)>90)=180-AoD(2,AoD(2,:)>90);
    AoD(2,AoD(2,:)<0)=-AoD(2,AoD(2,:)<0);
    AoA(2,AoA(2,:)>90)=180-AoA(2,AoA(2,:)>90);
    AoA(2,AoA(2,:)<0)=-AoA(2,AoA(2,:)<0);
    for j = 1:Nc*Nray
    alpha(j) = normrnd(0,sqrt(sigma/2)) + normrnd(0,sqrt(sigma/2))*sqrt(-1);
    end
%     gamma = sqrt((Nt*Nr)/(Nc*Nray));
%     g=gamma*alpha;
g = (randn(1,Nc*Nray)+1i*randn(1,Nc*Nray))/sqrt(Nc*Nray)/sqrt(2);
    H(:,:,reali) = scatteringchanmtx_0(txpos,rxpos,AoD,AoA,g,patternrE);
    
    H(:,:,reali)=Zt_64*H(:,:,reali)*Zr;
    
    
% H(:,:,reali) = scatteringchanmtx_1(newtxpos,rxpos,AoD,AoA,g,vert);
    [U,S,V] = svd(H(:,:,reali));
    Fopt(:,:,reali) = V([1:Nt],[1:Ns]);
    Wopt(:,:,reali) = U([1:Nr],[1:Nr]);
    
    rxarray2 =phased.URA([sqrt(Nr)/2 sqrt(Nr)],lambda/2);
rxpos2 = getElementPosition(rxarray2)/lambda;
rxpos2=[rxpos2(2,:);rxpos2(3,:);rxpos2(1,:)];

        H2(:,:,reali) = scatteringchanmtx_0(txpos,rxpos2,AoD,AoA,g,patternrE);
    
    
    H2(:,:,reali)=Zt_32*H2(:,:,reali)*Zr;
    
    
    
    
end
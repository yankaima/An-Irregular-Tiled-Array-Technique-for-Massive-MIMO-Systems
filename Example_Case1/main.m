
%% this case is corrpsonding to fig. 7 in case 1
%% the case can be runned in matlab 2020
clear
realization=1000;
M=8;N=8;%%% receiving array is 8*8 planar array
total_catagory=2;
T=M*N/2;
Nr=M*N;
Nt=16;
Ns=16;
angle_sigma=5/180*pi;
%%%%  it is difficult to express the range of theta phi if the array is located in yz plane
%%% hence, assume that the array is located in xy plane(it is different with paper).
%%% phi is the azimuth angle, which is the angle between the x-axis and the projection of the arrival direction vector onto the xy plane. It is positive when measured from the x-axis toward the y-axis.

%%%theta is the elevation angle, which is the angle between the arrival direction vector and xy-plane. It is positive when measured towards the z axis.
%%%% theta=0 deg is corrsponding to x-axis; theta=90 deg is corrsponding to z-axis; 
%%%% given the celluar situation(120deg coverage), theta=[60,90] and phi=[0, 360]
%%%% actually, in practical, the antenna pattern can not cover 180deg due to the isotropic radiator can not exist.
AoD_m_thetamin=-pi/2+pi/2;
AoD_mthetamax=pi/2;
AoA_m_thetamin=-pi/2+pi/2;
AoA_mthetamax=pi/2;
load pattern.mat
load C_pararmater_64.mat
load C_pararmater_32.mat
load C_pararmater_16.mat
[H,H2,~,~]=channel_realization_regular(Ns,Nt,Nr,realization,angle_sigma,AoD_m_thetamin,AoD_mthetamax,AoA_m_thetamin,AoA_mthetamax,patternrE,Zr,Zt_64,Zt_32);

SNR_dB = -30:5:10;
SNR = 10.^(SNR_dB./10);
smax = length(SNR);
Rox=zeros(1,smax);
Ro_best=zeros(1,smax);
Ro2x=zeros(1,smax);
Ro_GorokohovSelected=zeros(1,smax);
%% solution is the solved irregular array configuation

solution=[0,1,0,0,0,1,0,0,1,0,1,0,0,1,0,1,0,0,1,0,0,1,0,0,0,0,0,1,0,1,0,0,0,1,0,0,0,0,1,0,1,0,0,0,0,1,0,1,0,1,0,1,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,1,0,0,0,1,0,0,1,0,0,0,1,0,0,0,1,0,0,0,1,0,1,0,1,0,1,0,0,1,0,0,1,0,0,1,0,0,0,0,1,0,0,1];
sol_index=find(solution>0.5);
countset=collect_2s(M,N);
combiningset=collect_combining(countset,M,N);
combining=combiningset(:,sol_index);%%% combining is corresponding to the converison matrix A. 

Lr=Nr/2;
for s = 1:smax
    for reali=1:realization
        
        [U,S,V] = svd(H(:,:,reali));
        Fopt = V([1:Nt],[1:Ns]);
        Wopt = U([1:Nr],[1:Ns]);
        Rox(s) =Rox(s)+log2(det(eye(Ns) + SNR(s)/Ns *pinv(Wopt) * H(:,:,reali) *Fopt * Fopt' * H(:,:,reali)' * Wopt  ));
        [U,S,V] = svd(H2(:,:,reali));
        Fopt = V([1:Nt],[1:Ns]);
        Wopt = U([1:Lr],[1:Ns]);
        Ro2x(s) = Ro2x(s)+log2(det(eye(Ns) + SNR(s)/Ns *  pinv(Wopt) * H2(:,:,reali) *Fopt * Fopt' * H2(:,:,reali)' * Wopt ));
        H_best=combining'*H(:,:,reali)/sqrt(2);
        [U,S,V] = svd(H_best);
        Fopt = V([1:Nt],[1:Ns]);
        Wopt = U([1:Lr],[1:Ns]);
        Ro_best(s) =Ro_best(s)+log2(det(eye(Ns) + SNR(s)/Ns * pinv(Wopt) * H_best *Fopt * Fopt' * H_best' * Wopt));
        fullAntenna=[1:Nr];
        Ro_GorokohovSelected(s)=Ro_GorokohovSelected(s)+gorokohovSelected(Nr,Nt,Ns,Lr,SNR(s),H(:,:,reali),fullAntenna);
    end
end

figure(2)
hold on
plot(SNR_dB,Rox/realization,'k-o','LineWidth',1.5); %%%DBF with 64 RF chains in receiver
plot(SNR_dB,Ro_best/realization,'r-o','LineWidth',1.5);%%%FDIA with 32 RF chains in receiver
plot(SNR_dB,Ro2x/realization,'c-+','LineWidth',1.5);%%%DBF with 32 RF chains in receiver
plot(SNR_dB,Ro_GorokohovSelected/realization,'y-+','LineWidth',1.5);%%%antenna selection with 32 RF chains in receiver
grid on

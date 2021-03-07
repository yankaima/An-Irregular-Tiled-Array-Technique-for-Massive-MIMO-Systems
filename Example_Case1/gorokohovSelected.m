%%% this part code is followed by yusonghust's code(https://github.com/yusonghust/Antenna-Selection)
%%% the algorithm is from A. Gorokhov's ��Receive antenna selection for MIMO flat-fading channels: theory and algorithms,�� IEEE Trans. Inf. Theory, vol. 49, pp. 2687-2696, Oct. 2003.
%%%assuming the feedback of receiver is  sufficient.

function  SEOfSelected=gorokohovSelected(Nr,Nt,Ns,Lr,SNR,H,fullAntenna);
if(Lr==Nr)
     [U,S,V] = svd(H);
        Fopt = V([1:Nt],[1:Ns]);
        Wopt = U([1:Nr],[1:Ns]);
        SEOfSelected=log2(det(eye(Ns) + SNR/Ns *pinv(Wopt) * H *Fopt * Fopt' * H' * Wopt  ));
else
    B=inv(eye(Nt,Nt)+SNR/Ns*(H'*H));%��ʼ��B
    for n=1:(Nr-Lr)   %��������ѭ��һ������һ�����ߣ����µ�����Ҫ������
        Alpha=[];
        for j=1:length(fullAntenna)   %��ʼ��Alpha
            f=H(j,:);
            h=f';
            alpha=h'*B*h;%����
            Alpha=[Alpha alpha]; %��¼ÿһ�ε�alpha
        end
        [minOfAlpha,index]=min(Alpha);  %ѡ�����J��Ӧ������
        fullAntenna(index)=[]; %����������
        
        if (n<Nr-Lr)
            f=H(index,:);
            h=f';
            alpha=Alpha(index);
            a=B*h;
            B=B+a*a'/(Nt/SNR-alpha);
        end
    end
    H_sel=H(fullAntenna,:);
    [U,S,V] = svd(H_sel);
        Fopt = V([1:Nt],[1:Ns]);
        Wopt = U([1:Lr],[1:Ns]);
        SEOfSelected=log2(det(eye(Ns) + SNR/Ns *pinv(Wopt) * H_sel *Fopt * Fopt' * H_sel' * Wopt  ));

end
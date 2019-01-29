function [E_best,bool]=packing_st(xi,yi,zi,mi,si,ui,bi,l,w,h)
bool=0;
num=size(si,1);
l_=zeros(1,num);
w_=zeros(1,num);
h_=zeros(1,num);
E_best=0;
    for i=1:num
        switch mi(i)
            case 1
                l_(i)=l(i);
                w_(i)=w(i);
                h_(i)=h(i);
            case 2
                l_(i)=l(i);
                w_(i)=h(i);
                h_(i)=w(i);
            case 3
                l_(i)=w(i);
                w_(i)=l(i);
                h_(i)=h(i);
            case 4
                l_(i)=w(i);
                w_(i)=h(i);
                h_(i)=l(i);
            case 5
                l_(i)=h(i);
                w_(i)=l(i);
                h_(i)=w(i);
            case 6
                l_(i)=h(i);
                w_(i)=w(i);
                h_(i)=l(i);
            otherwise
                bool=0;
                E_best=inf;
                return;
        end
        if yi(i)+w_(i)>92
            bool=0;
            E_best=inf;
            return; 
        end
        if zi(i)+h_(i)>94
            bool=0;
            E_best=inf;
            return;
        end
        if E_best<xi(i)+l_(i)
            E_best=xi(i)+l_(i);
        end
    end
    for i=1:num
        for j=1:num
            if j~=i
               if  92*(1-ui(i,j))<(yi(i)-yi(j)+w_(i))
                    bool=0;
                    E_best=inf;
                    return;
               end
               if 94*(1-bi(i,j))<(zi(i)-zi(j)+h_(i))
                   bool=0;
                   E_best=inf;
                   return;
               end
               if si(i,j)==1
                   if xi(i)>xi(j)-l_(i)
                       bool=0;
                       E_best=inf;
                       return;
                   end
               else
                   if E_best<(xi(i)-xi(j)+l_(i))
                       E_best=(xi(i)-xi(j)+l_(i));
                   end
               end   
            end    
        end 
    end
bool=1;
end


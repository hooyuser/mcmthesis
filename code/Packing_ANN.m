function L_min = Packing_ANN(l,w,h)


a=0.95;  
num=size(l,1);
E_current = inf;
E_best = inf;
E_new = inf;
xi_new=ceil(rand(1,num)*924);
yi_new=ceil(rand(1,num)*92);
zi_new=ceil(rand(1,num)*94);
mi_new=ceil(rand(1,num)*6);
si_new=ceil(rand(num,num)+0.5)-1;
ui_new=zeros(num,num);
bi_new=zeros(num,num);
for i=1:num
    for j=1:num
        if si_new(i,j)==1
            ui_new(i,j)=0;
            bi_new(i,j)=0;
        else
            k=ceil(rand+0.5)-1;
            if k==1
                ui_new(i,j)=1;
                bi_new(i,j)=0;
            else
                ui_new(i,j)=0;
                bi_new(i,j)=1;
            end
        end
    end
end
xi_cur=xi_new;
yi_cur=yi_new;
zi_cur=zi_new;
mi_cur=mi_new;
si_cur=si_new;
ui_cur=ui_new;
bi_cur=bi_new;

xi_best=xi_new;
yi_best=yi_new;
zi_best=zi_new;
mi_best=mi_new;
si_best=si_new;
ui_best=ui_new;
bi_best=bi_new;
to=100;        
tf=3;          
t=to;




while  t>=tf
    for r = 1:10000  
        six=ceil(rand*6);
        tmp=ceil(rand*num);
        switch six
            case 1
                if(E_best<924)
                    xi_new(tmp)=ceil(rand*924);
                else
                    xi_new(tmp)=ceil(rand*E_best);
                end
            case 2
                yi_new(tmp)=ceil(rand*92);
            case 3
                zi_new(tmp)=ceil(rand*94);
            case 4
                mi_new(tmp)=ceil(rand*6);
            case 5
                tmp2=ceil(rand*num);
                while tmp2==tmp
                    tmp2=ceil(rand*num);
                end
                si_new(tmp,tmp2)=ceil(rand+0.5)-1;
                if si_new(tmp,tmp2)==1
                    ui_new(tmp,tmp2)=0;
                    bi_new(tmp,tmp2)=0;
                else
                    bi_new(tmp,tmp2)=1-ui_new(tmp,tmp2);
                end
            case 6
                tmp2=ceil(rand*num);
                while tmp2==tmp
                    tmp2=ceil(rand*num);
                end
                ui_new(tmp,tmp2)=ceil(rand+0.5)-1;
                if ui_new(tmp,tmp2)==1
                    si_new(tmp,tmp2)=0;
                    bi_new(tmp,tmp2)=0;
                else
                    bi_new(tmp,tmp2)=1-si_new(tmp,tmp2);
                end
        end
        [E_new,bool]=packing_st(xi_new,yi_new,zi_new,mi_new,si_new,ui_new,bi_new,l,w,h);
        if bool==1
           if E_new<E_current
               E_current = E_new;
               switch six
                   case 1
                       xi_cur=xi_new;
                   case 2
                       yi_cur=yi_new;
                   case 3
                       zi_cur=zi_new;
                   case 4
                       mi_cur=mi_new;
                   case {5,6}
                       si_cur=si_new;
                       ui_cur=ui_new;
                       bi_cur=bi_new;
               end
               if E_new<E_best
                   E_best=E_new;
                   switch six
                       case 1
                           xi_best=xi_new;
                       case 2 
                           yi_best=yi_new;
                       case 3
                           zi_best=zi_new;
                       case 4
                           mi_best=mi_new;
                       case {5,6}
                           si_best=si_new;
                           ui_best=ui_new;
                           bi_best=bi_new;
                   end
               end
           else
               if rand<exp(-(E_new-E_current)/t)
                   E_current=E_new;
               switch six
                   case 1
                       xi_cur=xi_new;
                   case 2
                       yi_cur=yi_new;
                   case 3
                       zi_cur=zi_new;
                   case 4
                       mi_cur=mi_new;
                   case {5,6}
                       si_cur=si_new;
                       ui_cur=ui_new;
                       bi_cur=bi_new;
               end
               else 
               switch six
                   case 1
                       xi_new=xi_cur;
                   case 2
                       yi_new=yi_cur;
                   case 3
                       zi_new=zi_cur;
                   case 4
                       mi_new=mi_cur;
                   case {5,6}
                       si_new=si_cur;
                       ui_new=ui_cur;
                       bi_new=bi_cur;
               end
               end
           end 
        end  
    end   
    t = t * a;
end
L_min=E_best;
disp('最优解为:');
E_best
disp('每个盒子的坐标及摆放方向为:');
for i=1:num
    fprintf('\n第%d个盒子的位置坐标和体积及方向为:',i);
    tmp=[xi(i) yi(i) zi(i) l(i) w(i) h(i) mi(i)]
end

end


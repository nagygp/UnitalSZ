############################################################
###   Construction of the Bagchi-Bagchi cyclic unitals   ###
############################################################

LoadPackage("UnitalSZ");

BB_unitals:=function(n)
    local p,q,gq,gp,t,gamma,pts,us,u,ret,f,A0,Ainf,perm,B,j,BB;

    p:=n+1;
    q:=n^2-n+1;
    Print("# p=",p,", q=",q,"\n");
    if not(IsPrimePowerInt(p) and IsPrimePowerInt(q)) then 
        Print("# wrong input\n");
        return [];
    fi;
    
    gq:=Z(q)^((q-1)/(p-1));
    gp:=Z(p)^2;
    t:=First(Reversed(DivisorsInt(p-1)),x->Gcd(x,(q-1)/(p-1))=1);
    gamma:=Z(q)^t;
    pts:=Cartesian(GF(p),GF(q));
    us:=Filtered(Group(gp),u->Order(u)=Order(gp));
    ret:=[];

    for u in us do
        f:=function(x) if IsZero(x) then return 0*gp; else return u^LogFFE(x,gq); fi; end;
        A0:=Set(Union([0*gq],Elements(Group(gq))),x->[f(x),x]);
        Ainf:=Set(GF(p),x->Position(pts,[x,0*gq]));
        perm:=PermList(List(pts,y->Position(pts,y+[1,1])));
        B:=[Ainf];
        for j in [0..(q-1)/(p-1)-1] do 
            Add(B,Set(A0,x->Position(pts,[x[1],gamma^j*x[2]]))); 
        od;
        BB:=Union(List(B,x->Orbit(Group(perm),x,OnSets)));
        if Length(BB)=(p-1)^2*q and AU_IsUnitalBlockDesign(BB) then
            BB:=AbstractUnitalByDesignBlocks(BB);
            SetName(BB,Concatenation("BagchiBagchiCyclicUnital<",String(n),",",String(Length(ret)+1),">"));
            Add(ret,BB);
        fi;
    od;
    return ret;
end;

BB_unitals(3);
BB_unitals(4);
BB_unitals(6);
BB_unitals(7);

u4:=BB_unitals(4)[1];
u6:=BB_unitals(6)[1];
a:=AutomorphismGroup(u6);
Size(a);
StructureDescription(a);

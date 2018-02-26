#
# Constructions of different classes of abstract unitals
#
# Implementations
#

InstallGlobalFunction( HermitianAbstractUnital,
function( q )
    local pgl, bls, u;
    pgl := PGU( 3, q );
    pgl := Action( pgl, First( Orbits( pgl ), x -> Length( x ) = q^3 + 1 ) );
    bls := Union( [ 1, 2 ], First( Orbits( Stabilizer( pgl, [ 1, 2 ],
                                                       OnTuples ) ),
                                   x -> Length( x ) = q - 1 ) );
    bls :=Set( Orbit( pgl, bls, OnSets ) );
    u := AbstractUnitalByDesignBlocks( bls );
    SetName( u, Concatenation( "HermitianAbstractUnital(", String( q ),
                               ")" ) );
    return u;
end );

InstallGlobalFunction( AllBuekenhoutMetzAbstractUnitalParameters,
function( q )
    local y, filt, parampairs, noniso_params, autgr, mulgr_q2, mulgr_q,
        current_param, a, b, over, u, v, gamma, tau;
    if not IsPrimePowerInt( q ) then
        Error( "the argument must be a prime power" );
    fi;
    if IsOddInt( q ) then
        y := X( GF(q), "y" );
        filt := Filtered( Tuples( GF(q^2), 2 ), c -> c[1] <> Zero(GF(q^2)) );
        parampairs := Filtered( filt,
                                c -> RootsOfUPol( GF(q),
                                                  y^2 - ((c[2]^q - c[2])^2 +
                                                  4 * c[1]^(q + 1)) )
                                     = [] );
    fi;
    if IsEvenInt( q ) then
        filt := Filtered( Tuples( GF(q^2), 2 ), c -> c[1] <> Zero(GF(q^2)) and
                                                     not ( c[2] in GF(q) ) );
        parampairs := Filtered( filt,
                                c -> Trace( GF(q), c[1]^(q + 1) / (c[2]^q +
                                                   c[2])^2 )
                                     = Zero( GF(2) ) );
    fi;

    noniso_params := [];

    autgr := Group( FrobeniusAutomorphism( GF(q^2) ) );
    mulgr_q2 := Group( PrimitiveElement( GF(q^2) ) );
    mulgr_q := Group( PrimitiveElement( GF(q) ) );

    while parampairs <> [] do
        over := false;
        current_param := Remove( parampairs );
        a := current_param[1];
        b := current_param[2];
        Add( noniso_params, current_param );
        for u in GF(q) do
            for v in mulgr_q do
                for gamma in mulgr_q2 do
                    for tau in autgr do
                        parampairs := Filtered( parampairs, param -> not (
                                        param[1] = a^tau * gamma^2 * v and
                                        param[2] = b^tau * gamma^(q+1)*v + u ));
                        if parampairs = [] then
                            over := true;
                            break;
                        fi;
                    od;
                    if over then break; fi;
                od;
                if over then break; fi;
            od;
            if over then break; fi;
        od;
    od;
    return noniso_params;
end );

InstallGlobalFunction( OrthogonalBuekenhoutMetzAbstractUnital,
function( q, alpha, beta )
    local y, bm_points, x, r, v, bmat, a, line, blist, mb, u;
    if not IsPrimePowerInt( q ) then
        Error( "the first parameter must be a prime power" );
    fi;
    if IsOddInt( q ) then
        y := X( GF(q), "y" );
        if RootsOfUPol( GF(q),
                        y^2 - ((beta^q - beta)^2 + 4 * alpha^(q + 1)) )
           <> [] then
           Error( "(beta^q - beta)^2 + 4 * alpha^(q + 1) must be a nonsquare over GF(q) for odd q" );
        fi;
    fi;
    if IsEvenInt( q ) then
        if Trace( GF(q), alpha^(q + 1) / (beta^q + beta)^2 ) <> Zero( GF(2) )
            then
           Error( "alpha^(q + 1) / (beta^q + beta)^2 must have absolute trace 0 for even q" );
        fi;
        if q < 4 then
            Error( "if q is even, then it must be at least 4" );
        fi;
    fi;
    bm_points := [];
    for x in GF(q^2) do;
        for r in GF(q) do;
            v := [ x, alpha*x^2 + beta*x^(q + 1) + r, One(GF(q^2)) ];
            Add( bm_points, v );
        od;
    od;
    v := [ Zero(GF(q^2)), One(GF(q^2)), Zero(GF(q^2)) ];
    Add( bm_points, v );
    bmat := [];
    for a in GF(q^2) do;
        line := [ One(GF(q^2)), Zero(GF(q^2)), a ];
        blist := List( bm_points, p -> line * p = Zero(GF(q^2)) );
        if SizeBlist( blist ) = q + 1 then
            Add( bmat, blist );
        fi;
    od;
    for mb in Tuples( GF(q^2), 2 ) do;
        line := [ mb[1], One(GF(q^2)), mb[2] ];
        blist := List( bm_points, p -> line * p = Zero(GF(q^2)) );
        if SizeBlist( blist ) = q + 1 then
            Add( bmat, blist );
        fi;
    od;
    u := AbstractUnitalByBlistList( bmat );
    SetName( u, Concatenation( "OrthogonalBuekenhoutMetzAbstractUnital(", String(q), ",", String(alpha), ",", String(beta), ")" ) );
    SetPointNamesOfUnital( u, bm_points );
    return u;
end );

InstallGlobalFunction( BuekenhoutTitsAbstractUnital,
function( q )
    local tau, delta, bt_points, xy, v, bmat, a, line, blist, mb, u;
    if not IsPrimePowerInt( q ) or IsOddInt( q ) then
        Error( "the parameter must be power of 2 with odd exponent at least 3" );
    fi;
    if IsEvenInt( Dimension( GF(q) ) ) then
        Error( "the parameter must be power of 2 with odd exponent at least 3" );
    fi;
    tau := 2^( (Dimension( GF(q) ) + 1) / 2 );
    delta := First( GF(q^2), d -> d^q=d+1 and d<>d^(q-1) );
    bt_points := [];
    for xy in Tuples( GF(q), 3 ) do;
        v := [ xy[1] + xy[2]*delta,
               xy[3] + ( xy[1]^( tau + 2 ) + xy[2]^tau + xy[1]*xy[2] )*delta,
               One(GF(q^2)) ];
        Add( bt_points, v );
    od;
    v := [ Zero(GF(q^2)), One(GF(q^2)), Zero(GF(q^2)) ];
    Add( bt_points, v );
    bmat := [];
    for a in GF(q^2) do;
        line := [ One(GF(q^2)), Zero(GF(q^2)), a ];
        blist := List( bt_points, p -> line * p = Zero(GF(q^2)) );
        if SizeBlist( blist ) = q + 1 then
            Add( bmat, blist );
        fi;
    od;
    for mb in Tuples( GF(q^2), 2 ) do;
        line := [ mb[1], One(GF(q^2)), mb[2] ];
        blist := List( bt_points, p -> line * p = Zero(GF(q^2)) );
        if SizeBlist( blist ) = q + 1 then
            Add( bmat, blist );
        fi;
    od;
    u := AbstractUnitalByBlistList( bmat );
    SetName( u, Concatenation( "BuekenhoutTitsAbstractUnital(", String(q), ")" ) );
    SetPointNamesOfUnital( u, bt_points );
    return u;
end );

InstallGlobalFunction( BagchiBagchiCyclicUnital, 
function(n)
    local p,q,gq,gp,t,gamma,pts,us,u,f,A0,Ainf,perm,B,j,BB;

    # Parameter check
    p:=n+1;
    q:=n^2-n+1;
    if not(IsPrimePowerInt(p) and IsPrimePowerInt(q)) then 
        Error("wrong argument");
    fi;
    # For parameters n<=20, the only known cyclic unitals are for n=4 and n=6, and they are unique.
    # In order to force computation for an arbitrary n, comment out the next lines:
    if n in [2,3,7,15,16,18] then return fail; fi;
    if n > 20 then Error("computationally hopeless for orders > 20"); fi;
    # Preparation
    gq:=Z(q)^((q-1)/(p-1));
    gp:=Z(p)^2;
    t:=First(Reversed(DivisorsInt(p-1)),x->Gcd(x,(q-1)/(p-1))=1);
    gamma:=Z(q)^t;
    pts:=Cartesian(GF(p),GF(q));
    us:=Filtered(Group(gp),u->Order(u)=Order(gp));
    # Trying out admissible u's
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
        # Check for the unital property
        if Length(BB)=(p-1)^2*q and AU_IsUnitalBlockDesign(BB) then
            BB:=AbstractUnitalByDesignBlocks(BB);
            SetName(BB,Concatenation("BagchiBagchiCyclicUnital(",String(n),")"));
            SetPointNamesOfUnital(BB,pts); # sense???
            return BB;
        fi;
    od;
    return fail;
end);

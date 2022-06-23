using Revise
using ZonalFlow

tspan   = (0.0,1000.0);
tsargs  = (
            dt=0.001,
            adaptive=false,
            progress=false,
            progress_steps=10000,
            save_everystep=false,
            saveat=50
           );

domain  = Domain(extent=(2π,2π),res=(6,6));
coeffs  = Coefficients(Ω=0.0,θ=0.0,μ=0.0,ν=0.02,ν₄=0.0); # β=0
forcing = Kolmogorov(A₁=-1.0,A₄=-2.0);
prob    = BetaPlane(domain,coeffs,forcing);

eqs = [CE2(),GCE2(0)];
eqs⁺ = [CE2(poscheck=true,poscheckat=10),GCE2(Λ=0,poscheck=true,poscheckat=20)];

labels = ["ce2","gce2_0"]
labels⁺ = ["ce2_pos","gce2_0_pos"]

dn = "data/"

sol = integrate(prob,eqs[1],tspan;tsargs...);
write(prob,eqs[1],sol,dn=dn,fn=labels[1])

sol⁺ = integrate(prob,eqs⁺[1],tspan;tsargs...);
write(prob,eqs⁺[1],sol⁺,dn=dn,fn=labels⁺[1])

sol = integrate(prob,eqs[2],tspan;tsargs...);
write(prob,eqs[2],sol,dn=dn,fn=labels[2])

sol⁺ = integrate(prob,eqs⁺[2],tspan;tsargs...);
write(prob,eqs⁺[2],sol⁺,dn=dn,fn=labels⁺[2])

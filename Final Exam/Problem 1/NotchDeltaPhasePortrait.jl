include("PhasePortraitV2.jl")

# Function for the notch delta system in two cells in the limit v<<<1
# x1: range of x1 values (i.e. D1 values)
# x2: range of x2 values (i.e. D2 values)
# We use `@.` to apply the calculations across all rows.
# Note that model parameters are specified within the function
# Returns computed (dx1/dt, dx2/dt) over the range of (x1, x2)

#x1=[u], and x2=[v], the u,v below correspond with the respective time derivatives of the concentration

function notchdelta(x1, x2)

    u = @. -x1 + 1/(1+10*(x2^2/(0.1+x2^2))^2)      #eqn 3*
    v = @. -x2 + 1/(1+10*(x1^2/(0.1+x1^2))^2)      #eqn 5*

    return (u,v)
end

#Range of x1, x2 values
x1range = (0,1,15)          #Has the form (min, max, num points)
x2range = (0,1,15)          #Has the form (min, max, num points)


#initial state vectors; Uncomment each vector one at a time to generate the differnt plots
del=0.00001

x₀ = ([0.2+del,0.2],)  # Uncomment to generate the plot saved as D1=D2=0.2perturbD1
#x₀ = ([0.2,0.2+del],)  # Uncomment to generate the plot saved as D1=D2=0.2perturbD2
#x₀ = ([0.8+del,0.8],)  # Uncomment to generate the plot saved as D1=D2=0.8perturbD1
#x₀ = ([0.8,0.8+del],)  # Uncomment to generate the plot saved as D1=D2=0.8perturbD2

tspan=(0.0,100)             #time span

#Call the phaseplot functon to construct the phase portrait
phaseplot(notchdelta, x1range, x2range, xinit=(x₀), t=tspan, clines=true,
        norm=true, scale=0.5)

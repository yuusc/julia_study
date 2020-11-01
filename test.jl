using DifferentialEquations, Plots

y = 1.0
x0 = 1.0
f(x,p,t) = 2.0x + 5.0y
tspan = (0.0, 1.0)
prob = ODEProblem(f, x0, tspan)
sol = solve(prob)
println(sol)
plot(sol,xlims=(0, 2.0))

max = 10

for i in 1:max
    num = length(sol)
    if sol[1,num] > 0
        if sol[1,num] > 1
            y=y-sol[1,num]/2
        else
        y=y-sol[1,num]/5
        end
        f(x, p, t) = 2.0x + 5.0y
        tspan = (0.0, 2.0)
        prob = ODEProblem(f, x0, tspan)
        sol = solve(prob)
        println(sol)
        println(y)
        println(sol[1,num])
        println("a")
    elseif sol[1,num] < 0
        if sol[1,num] < 1
            y=y-sol[1,num]/2
        else
        y=y-sol[1,num]/5
        end
        f(x,p,t) = 2.0x + 5.0y
        tspan = (0.0, 2.0)
        prob = ODEProblem(f, x0, tspan)
        sol = solve(prob)
        println(sol)
        println(y)
        println(sol[1,num])
        println("b")
    end
    if i != max
        plot!(sol,xlims=(0, 2.0))
    end
end
plot!(sol,xlims=(0, 2.0))
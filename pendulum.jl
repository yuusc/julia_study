using DifferentialEquations, Plots

g = 9.8
m = 1
M = 1
B = 0.000027
C = 0.000027
l = 0.8
u = 0
G1 = 2.0
r = 0.0
J = m * l * l / 3
a0 = J * (m + M) + M * m * l * l
x0 = [0,0,0,0]

A = [0 0 1 0;0 0 0 1;0 -m * m * l * l * g / a0 -B * (J + m * l * l) / a0 a34 = C * m * l / a0;0 (m + M) * m * l * g / a0 B * m * l / a0 -C * (m + M) / a0]
B = [0;0;(J + m * l * l) / a0;-m * l / a0]
println("A: "*string(A))
println("B: "*string(B))
for i in 1:100
    println("i: "*string(i))
    f(x,p,t) = A * x + B * u
    tspan = (0.0, 1.0)
    prob = ODEProblem(f, x0, tspan)
    sol = solve(prob)
    println("sol: "*string(sol))
    println("x: "*string(float(sol[1,6])))
    x = [float(sol[1,6]),float(sol[2,6]),float(sol[3,6]),float(sol[4,6])]
    u = G1 * (r - float(sol[1,6]))
    println("theta: "*string(float(sol[2,6])))
    println("u: "*string(u))
    if float(sol[2,6])<-pi/2 || float(sol[2,6]) > pi/2
        println("fall down")
        exit
    end
end
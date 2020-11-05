using DifferentialEquations, Plots

g = 9.8
m = 1
M = 1
B = 0.000027
C = 0.000027
l = 0.8
u = 0
r = 0
G1 = 1.2
times = 6/11
J = m * l * l / 3
a0 = J * (m + M) + M * m * l * l
x0 = [0.0,0.1,0.0,0.0]

A = [0 0 1 0;0 0 0 1;0 -m * m * l * l * g / a0 -B * (J + m * l * l) / a0 a34 = C * m * l / a0;0 (m + M) * m * l * g / a0 B * m * l / a0 -C * (m + M) / a0]
B = [0;0;(J + m * l * l) / a0;-m * l / a0]
println("A: " * string(A))
println("B: " * string(B))
for i in 1:500
    println("i: " * string(i))
    f(x, p, t) = A * x + B * u
    tspan = (0.0, 2.0)
    prob = ODEProblem(f, x0, tspan)
    sol = solve(prob)
    num = length(sol)
    println("sol: " * string(sol))
    println("num: " * string(num))
    x = [float(sol[1,round(Int, num * times)]),float(sol[2,round(Int, num * times)]),float(sol[3,round(Int, num * times)]),float(sol[4,round(Int, num * times)])]
    u = G1 * (r - float(sol[1,round(Int, num * times)]))
    println("theta: " * string(float(sol[2,round(Int, num * times)])))
    println("u: " * string(u))
    println("x: " * string(float(sol[1,round(Int,num* times)])))
    if float(sol[2,round(Int, num * times)]) < -pi /2 || float(sol[2,round(Int, num * times)]) > pi / 2
        println("fall down")
        break
    end
end
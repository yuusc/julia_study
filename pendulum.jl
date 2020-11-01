using DifferentialEquations, Plots

g = 9.8
m = 1
M = 1
B = 0.000027
C = 0.000027
l = 0.8
u = 0
the = 0.3 #静止したい角度
J = m * l * l / 3
a0 = J * (m + M) + M * m * l * l
x0 = [0,0,0.1,0]

A = [0 0 1 0;0 0 0 1;0 -m * m * l * l * g / a0 -B * (J + m * l * l) / a0 a34 = C * m * l / a0;0 (m + M) * m * l * g / a0 B * m * l / a0 -C * (m + M) / a0]
B = [0;0;(J + m * l * l) / a0;-m * l / a0]
println(A)
println(B)
f(x,p,t) = A * x + B * u
tspan = (0.0, 1.0)
prob = ODEProblem(f, x0, tspan)
sol = solve(prob)
println(sol)
plot(sol,xlims=(0, 0.1),ylims=(the - 2.0, the + 2.0))   #最初の描画


if float(sol[2,2]) > the
    u=10    #最初の計算で角度が静止角度よりも大きかったらuを正に
elseif float(sol[2,2]) < the
    u=-10
end

max = 100   #forでの繰り返し最大回数
for i in 1:max
    println(i)
    println(float(sol[1,2]))
    x0 = [float(sol[1,2]),float(sol[2,2]),float(sol[3,2]),float(sol[4,2])]  #x0の値を計算結果より再設定
    if float(sol[2,2]) > the && float(sol[4,2]) > 0     #角度が静止角度よりも大きく，角速度が正だったら
        if float(sol[2,2]) > pi/3
            println("theta" * string(float(sol[2,2])))
            u = u + abs(float(sol[1,2]) - the) * 60
            println(u)
            f(x, p, t) = A * x + B * u
            tspan = (0.0, 1.0)
            prob = ODEProblem(f, x0, tspan)
            sol = solve(prob)
            println("aem")
        else
            println("theta" * string(float(sol[2,2])))
            u = u + abs(float(sol[1,2]) - the) * 25
            println(u)
            f(x, p, t) = A * x + B * u
            tspan = (0.0, 1.0)
            prob = ODEProblem(f, x0, tspan)
            sol = solve(prob)
            println("a")
        end
    elseif float(sol[2,2]) > the && float(sol[4,2]) < 0
        println("theta" * string(float(sol[2,2])))
        u = u - abs(float(sol[1,2]) - the) * 5
        println(u)
        f(x, p, t) = A * x + B * u
        tspan = (0.0, 1.0)
        prob = ODEProblem(f, x0, tspan)
        sol = solve(prob)
        println("b")
    elseif float(sol[2,2]) < the && float(sol[4,2]) > 0
        println("theta" * string(float(sol[2,2])))
        u = u + abs(float(sol[1,2]) - the) * 5
        println(u)
        f(x, p, t) = A * x + B * u
        tspan = (0.0, 1.0)
        prob = ODEProblem(f, x0, tspan)
        sol = solve(prob)
        println("c")
    elseif float(sol[2,2]) < the && float(sol[4,2]) < 0
        if float(sol[2,2]) < -pi/3
            println("theta" * string(float(sol[2,2])))
            u = u - abs(float(sol[1,2]) - the) * 60
            println(u)
            f(x, p, t) = A * x + B * u
            tspan = (0.0, 1.0)
            prob = ODEProblem(f, x0, tspan)
            sol = solve(prob)
            println("dem")
        else
            println("theta" * string(float(sol[2,2])))
            u = u - abs(float(sol[1,2]) - the) * 25
            println(u)
            f(x, p, t) = A * x + B * u
            tspan = (0.0, 1.0)
            prob = ODEProblem(f, x0, tspan)
            sol = solve(prob)
            println("d")
        end
    end
    if i != max
        plot!(sol, xlims=(0, 0.1), ylims=(the - 2.0, the + 2.0))
    end
    if float(sol[2,2]) < -pi/2 || float(sol[2,2]) > pi/2
        println("fall down"*string(i))
        break
    end
end
plot!(sol,xlims=(0, 0.1),ylims=(the - 2.0, the + 2.0))

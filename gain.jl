using DifferentialEquations, Plots

# パラメータ設定
g = 9.8
M = 0.2
l = 1.0
the = pi/2.0
dthe = 0.0
Tu = 0.0
kp = 10.0
ki = 5.0
kd = 0.8
dt = 0.1
theta = pi / 2.0
dtheta = 0.0

x = [theta,dtheta,(the - theta) * dt]
r = [the,dthe,l * M * g * sin(theta)]

f(x,p,t) = ([ 0.0 1.0 0.0;-kp -kd ki;-1.0 0.0 0.0]* x + [ 0.0 0.0 0.0;kp kd -1.0;1.0 0.0 0.0] * r) / (4 * M * l * l / 3)
tspan = (0.0,3.0)

println("目標値: " * string(the) * ", 初期値: " * string(theta))

    prob = ODEProblem(f, x, tspan)
    sol = solve(prob,saveat = 0.05) # 状態方程式を解く
    println("sol: " * string(sol))
# グラフを描画
plot(sol)
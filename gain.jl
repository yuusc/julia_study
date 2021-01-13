using DifferentialEquations, Plots

# パラメータ設定
g = 9.8
M = 0.2
l = 1.0
I = 4 * M * l * l / 3

the = pi/3
dthe = 0.0
Tu = 0.0


# 制御

 kp = 5.0
 ki = 5.0
 kd = 1.0

#kp = 0.0
#ki = 0.0
#kd = 0.0

dt = 0.01

theta = pi/2
dtheta = 0
F = l * M * g * sin(theta)
thearray = [theta] # グラフ描画用　角度の配列

z = (the - theta) * dt

A = [ 0 1 0
    -kp -kd ki
    -1 0 0]
B = [ 0 0 0
    kp kd -1
    1 0 0]
x = [theta,dtheta,z]
r = [the,dthe,F]
f(x,p,t) = (A * x + B * r) / I
tspan = dt

println("目標値: "*string(the)*", 初期値: "*string(theta))


# 一定時間進める→PIDで計算→thetaとTuを再設定→再度時間を進める　という流れをODEProblemのみで実行するのは不可能そう
# ↑ここから                               ↑ここまでを1サイクルとしてfor文を回す方法しか思いつかない．検索しても適切なものは発見できなかった．
# [0.0, 0.1, 0.2,...]ではなく[0.0, 0.1][0.1, 0.2][0.2, 0.3]... となる．結果を配列に突っ込むため問題はないはず．
for i in 1:5
    println(string((i - 1) * dt) * "~" * string(i * dt) * "s")
    prob = ODEProblem(f, x, tspan)
    sol = solve(prob, save_everystep=false) # 状態方程式を解く
    println("sol: " * string(sol))

    #計算結果
    dtheta = sol[1,2]
    ddtheta = sol[2,2]
    dz = sol[3,2]
    theta = the - dz
    z = (the - theta) * dt
    Tu = kp * (the - theta) + ki * z + kd * (dthe - dtheta)
    println("theta: " * string(theta))
    println("dtheta: " * string(dtheta))
    println("ddtheta: " * string(ddtheta))
    println("Tu: " * string(Tu))
    println("z: " * string(z))
    println("dz: " * string(dz))
    println("")

    #前回の値を代入
    z = (the - theta) * dt
    F = l * M * g * sin(theta)
    x = [theta,dtheta,z]
    r = [the,dthe,F]
    f(x,p,t) = (A * x + B * r) / I

    push!(thearray, theta) # 角度を配列に追加
end
# グラフを描画
plot(thearray,title="Rigid body pendulum",xaxis="Time (10^(-2)s)",yaxis="Angle (rad)",label="theta")
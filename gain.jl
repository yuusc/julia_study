using DifferentialEquations, Plots

# パラメータ設定
g = 9.8
M = 0.1
l = 1.0

I = 4 * M * l * l / 3
the = pi / 2
Tu = 0.0
theta0 = pi / 2
ddtheta0 = (Tu - l * M * g * sin(pi/2)) / I
thearray = [v0] # グラフ描画用　角度の配列
ddthearray = [u0] # グラフ描画用　各加速度の配列
#preP = the - pi/2
#I = 0.0
#D = 0.0
#G1 = 15
#G2 = 25
#G3 = 50
# 制御

f(dtheta,theta,p,t) = (Tu - l * M * g * sin(theta)) / I

theta = theta0 
ddtheta = ddtheta0 
tspan = 0.01

#一定時間進める→PIDで計算→thetaとTuを再設定→再度時間を進める　という流れをODEProblemのみで実行するのは不可能そう
#↑ここから                               ↑ここまでを1サイクルとしてfor文を回す方法しか思いつかない．検索しても適切なものは発見できなかった．
#[0.0, 0.1, 0.2,...]ではなく[0.0, 0.1][0.1, 0.2][0.2, 0.3]... となる．結果を配列に突っ込むため問題はないはず．
for i in 1:100
    prob = SecondOrderODEProblem(f, theta, ddtheta, tspan)
    sol = solve(prob, save_everystep=false) # 状態方程式を解く
    println("sol: " * string(sol))
    theta=sol[2,1]
    println("theta: "*string(v))
    ddtheta = (Tu- l * M * g * sin(v))/I
    println("ddtheta: "*string(u))
    push!(thearray,theta) # 角度を配列に追加
    push!(ddthearray,ddtheta)
end
# グラフを描画
plot(thearray,title="Rigid body pendulum",xaxis="Time (10^(-1)s)",yaxis="",label="theta")
plot!(ddthearray,label="ddtheta")
using DifferentialEquations, Plots

#パラメータ設定
g = 9.8
m = 1
M = 1
B = 0.000027
C = 0.000027
l = 0.8
u = 0
r = 0.2
the = 0.0
G1 = 20
G2 = 9.0
G3 = 0.5
dt = 0.05/1000
J = m * l * l / 3
a0 = J * (m + M) + M * m * l * l
x = [0.0,0.1,0.0,0.0]
preP = r - x[1,1]
I = 0.0
D = 0.0
thearray = [0.1] #グラフ描画用　角度の配列
xarray = [0.0] #グラフ描画用　位置の配列

A = [0 0 1 0;0 0 0 1;0 -m * m * l * l * g / a0 -B * (J + m * l * l) / a0 a34 = C * m * l / a0;0 (m + M) * m * l * g / a0 B * m * l / a0 -C * (m + M) / a0]
B = [0;0;(J + m * l * l) / a0;-m * l / a0]
println("A: " * string(A))
println("B: " * string(B))

#制御

for i in 1:50
    println("i: " * string(i))
    f(x, p, t) = A * x + B * u
    tspan = (0.0, 0.05)
    prob = ODEProblem(f, x, tspan)
    sol = solve(prob) #状態方程式を解く
    num = length(sol) #要素数
    println("sol: " * string(sol))
    println("num: " * string(round(Int,num)))
    x = [float(sol[1,round(Int, num )]),float(sol[2,round(Int, num)]),float(sol[3,round(Int, num)]),float(sol[4,round(Int, num)])] #xの再設定
    global P = r - float(sol[2,round(Int, num)])　#Pの設定
    global I = I + P * dt #Iの設定
    global D = P - preP　#Dの設定
    global preP = P #次のPの準備
    global u = G1 * P + G2 * I + G3 * D #PID制御を使用したuの設定
    println("theta: " * string(float(sol[2,round(Int, num)])))
    println("u: " * string(u))
    println("x: " * string(float(sol[1,round(Int,num)])))
    push!(thearray,float(sol[2,round(Int, num)])) #角度を配列に追加
    push!(xarray,float(sol[1,round(Int, num)])) #位置を配列に追加

    #倒れたことを判定

    if float(sol[2,round(Int, num)]) < -pi /2 || float(sol[2,round(Int, num)]) > pi / 2
        println("fall down")
        break
    end
end

#グラフを描画

plot(thearray,ylims=(-0.5,0.5))
plot!(xarray)
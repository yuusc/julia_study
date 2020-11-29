using Plots

# パラメータ設定
g = 9.8
m = 1
M = 1
B = 0.000027
C = 0.000027
l = 0.8
u = 0.1
r = 0
the = 0.0
J = m * l * l / 3
a0 = J * (m + M) + M * m * l * l
x = [0.0,0.1,0.0,0.0]
preP = the - x[2,1]
prePr = r - x[1,1]
I = 0.0
Ir = 0.0
D = 0.0
Dr = 0.0
thearray = [0.1] # グラフ描画用　角度の配列
xarray = [0.0] # グラフ描画用　位置の配列

A = [0 0 1 0
    0 0 0 1
    0 -m * m * l * l * g / a0 -B * (J + m * l * l) / a0 a34 = C * m * l / a0
    0 (m + M) * m * l * g / a0 B * m * l / a0 -C * (m + M) / a0]
B = [0;0;(J + m * l * l) / a0;-m * l / a0]

dt = 0.01
h1 = x
u1 = u
u2 = u
rt = 0
rtswitch = 0


println("A: " * string(A))
println("B: " * string(B))

# 制御

G1 = 33.0
Gr1 = 0.89
G2 = -14.445
Gr2 = 0.07
G3 = -1.63
Gr3 = 2.0
for i in 1:1000
t = i*dt
println("t:"*string(t))
#常微分方程式を解く
h2 = ([1 0 0 0;0 1 0 0;0 0 1 0;0 0 0 1]-(dt/2)*A)\(([1 0 0 0;0 1 0 0;0 0 1 0;0 0 0 1]+(dt/2)*A)*h1+(dt/2)*B*(u1+u2))
h1 = h2 #再設定
u1 = u2
#thetaとxを交互に判定
    #角度
    if rtswitch == 0 #thetaで判定
    global P = the - float(h2[2,1])　#Pの設定
    global I = I + P * dt #Iの設定
    global D = P - preP　#Dの設定
    global preP = P #次のPの準備
    global u2 = -(G1 * P + G2 * I + G3 * D)*2 #PID制御を使用したuの設定
    rtswitch　= rtswitch + 1
    println("theta,u2:"*string(u2))
    elseif rtswitch == 1 #rで判定
    global Pr = r - float(h2[1,1])　#Pの設定
    global Ir = Ir + Pr * dt #Iの設定
    global Dr = Pr - prePr　#Dの設定
    global preP = Pr #次のPの準備
    global u2 = (Gr1 * Pr + Gr2 * Ir + Gr3 * Dr) #PID制御を使用したuの設定
    rtswitch = 0
    println("r,u2:"*string(u2))
    end
    println(h2)
    #配列に追加（グラフ用）
    push!(thearray,h2[2,1])
    push!(xarray,h2[1,1])
end
#グラフ描画
plot(thearray,ylims=(-1.0,1.0))
plot!(xarray)
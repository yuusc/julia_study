global P = the - v　#Pの設定
    global I = I + P * tspan #Iの設定
    global D = P - preP　#Dの設定
    global preP = P #次のPの準備
    global Tu = -(G1 * P + G2 * I + G3 * D) #PID制御を使用したuの設定

    http://cacsd2.sakura.ne.jp/2019/08/02/%E5%89%9B%E4%BD%93%E6%8C%AF%E3%82%8A%E5%AD%90/
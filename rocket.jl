vreq = 16500 # m/s,必要速度
mp = 0.5# ton,探査機質量
# 燃料ごとの比推力の設定(sec)
oxhy = 450 # 液体酸素/液体水素
oxga = 350 # 液体酸素/天然ガス
oxke = 330 # 液体酸素/ケロシン
hynto = 310 # ヒドラジン/NTO
con = 280 # コンポジット固体

oxhys = "液体酸素/液体水素" 
oxgas = "液体酸素/天然ガス" 
oxkes = "液体酸素/ケロシン" 
hyntos = "ヒドラジン/NTO" 
cons = "コンポジット固体" 

isp = 0.0
ve = 0.0



# 構造効率の設定(デフォルト)
steff1 = 0.9
steff2 = 0.85
steff3 = 0.85
steff4 = 0.85

array = [0.0]
pop!(array)


stnum = 3 # ロケット段数,デフォルト値
m0 = 400 #ton,全備質量
# array = [1.0, 0.9, 1.0, 0.85, 1.0, 0.85]


    stnum = Base.prompt("段数は?(3 or 4)")
    println("段数:" * stnum)
    stnum = parse(Int, stnum)
    for i in 1:stnum
        println("1:" * oxhys)
        println("2:" * oxgas)
        println("3:" * oxkes)
        println("4:" * hyntos)
        println("5:" * cons)
        text = Base.prompt(string(i) * "段目の種類は?(1~5)")
        text = parse(Float64, text)
        push!(array, text)
        text = Base.prompt(string(i) * "段目の構造効率は？(1段目:0.8~0.9, 2段目以降:0.85以下)")
        text = parse(Float64, text)
        push!(array, text)
        println(array)
        
        if array[3i - 2,1] == 1.0
            push!(array,oxhy)
        elseif array[3i - 2,1] == 2.0
            push!(array,oxga)
        elseif array[3i - 2,1] == 3.0
            push!(array,oxke)
        elseif array[3i - 2,1] == 4.0
            push!(array,hynto)
        elseif array[3i-2,1]==5.0
            push!(array,con)
        end
        println("種類" * string(array[3i - 2,1]) * ", 構造効率" * string(array[3i-1,1])*",比推力"*string(array[3i,1]))
    end

#質量の設定
m1= m0*0.7
m2 = m0*0.2
m1t = m1*array[2,1]
mst1 = m1-m1t
m2t = m2*array[5,1]
mst2 = m2-m2t

m01=m0+mp
mt1=m01-m1t
m02=mt1-mst1
mt2=m02-m2t
m03=mt2-mst2

if stnum == 4
    m3 = m0*0.05
    m4 = m0*0.05
    m3t = m3*array[8,1]
    mst3 = m3-m3t
    m4t = m4*array[11,1]
    mst4 = m4-m4t

    mt3 = m03-m3t
    m04 = mt3-mst3
    mt4 = m04-m4t

    if mt4 == mst4+mp
        println("検証成功")
    end

    del1 = array[3,1]*9.8*log(m01/mt1)
    del2 = array[6,1]*9.8*log(m02/mt2)
    del3 = array[9,1]*9.8*log(m03/mt3)
    del4 = array[12,1]*9.8*log(m04/mt4)

else
    m3 = m0*0.1
    m3t = m3*array[8,1]
    mst3 = m3-m3t

mt3 = m03-m3t
m04 = 0.0
mt4 = 0.0

if mt3 == mst3+mp
    println("検証成功")
end

    del1 = array[3,1]*9.8*log(m01/mt1)
    del2 = array[6,1]*9.8*log(m02/mt2)
    del3 = array[9,1]*9.8*log(m03/mt3)
    del4 = 0.0

end

println(array)
println("m01:"*string(m01))
println("mt1:"*string(mt1))
println("m02:"*string(m02))
println("mt2:"*string(mt2))
println("m03:"*string(m03))
println("mt3:"*string(mt3))
println("m04:"*string(m04))
println("mt4:"*string(mt4))
println("del1:"*string(del1))
println("del2:"*string(del2))
println("del3:"*string(del3))
println("del4:"*string(del4))

println("log(m01/mt1):"*string(log(m01/mt1)))
println("log(m02/mt2):"*string(log(m02/mt2)))
println("log(m03/mt3):"*string(log(m03/mt3)))
println("log(m04/mt4):"*string(log(m04/mt4)))


delv = del1+del2+del3+del4
println(delv)

if delv > vreq
    println("打ち上げ可能です")
else
    println("打ち上げ不可能です")
end
#課題2
max  = 131  #右側
min  = 0    #左側

#判定範囲: 0~130歳

    while max - min > 1
        mid = round(min + (max - min) / 2)　#左側と右側を取り，中央の値を取得，小数を丸める
        print(mid)
        println("歳以上ですか？(yes/no)")
        ans = chomp(readline())　#文字列を取得( readline() )，最後の文字を削除（改行を削除）( chomp )
        if ans == "yes"
            global min = mid
        else
            global max = mid
        end
    end
    print(min)
    print("歳です")

#=
#検証用

max  = 131  #右側
min  = 0    #左側
x = 0

for i in 0:130

    while max - min > 1
        mid = round(min + (max - min) / 2)　#左側と右側を取り，中央の値を取得，小数を丸める
        #print(mid)
        #println("歳以上ですか？(yes/no)")
        if i >= mid
            ans = "yes"
        elseif i < mid
            ans= "no"
        end
        if ans == "yes"
            global min = mid
        else
            global max = mid
        end
    end
    print(min)
    println("歳です")
    global x = x + min
    global max  = 131
    global min  = 0
end
if x == 8515
    print("検証が完了しました")
else
    print("検証に失敗しました")
end
=#
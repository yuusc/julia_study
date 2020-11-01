#課題2
max  = 131  #右側
min  = 0    #左側
function age(ans)
    while max - min > 1
        mid = round(min + (max - min) / 2)　#左側と右側を取り，中央の値を取得，小数を丸める
        print(mid)
        print("歳以上ですか？(yes/no)")
        ans = chomp(readline())　#文字列を取得( readline() )，最後の文字を削除（改行を削除）( chomp )
        if ans == "yes"
            global min = mid
        else
            global max = mid
        end
    end
    print(min)
    print("歳です")
end

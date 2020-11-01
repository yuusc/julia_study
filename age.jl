#課題2
max  = 131
min  = 0
function age(ans)
    while max - min > 1
        mid = round(min + (max - min) / 2)
        print(mid)
        print("歳以上ですか？(yes/no)")
        ans = chomp(readline())
        if ans == "yes"
            global min = mid
        else
            global max = mid
        end
    end
    print(min)
    print("歳です")
    # "歳より上ですか？(yes/no)"
end
#まだ
age = 0
while age < 140
    ans(age)
    age ++
end

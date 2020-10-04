i = 1
for i in 1:100
    if (i % 3 == 0) & (i % 5 == 0)
        print("fizzbuzz")
    elseif (i % 3 == 0)
        print("fizz")
    elseif (i % 5 == 0)
        print("buzz")
    else
        print(i)
    end
    print(",")
end
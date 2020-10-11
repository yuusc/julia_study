i = 1
for i in 1:100
    if (i % 3 == 0) & (i % 5 == 0)
        println("fizzbuzz")
    elseif (i % 3 == 0)
        println("fizz")
    elseif (i % 5 == 0)
        println("buzz")
    else
        println(i)
    end
end
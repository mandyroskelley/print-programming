
my_list :: [Float]
my_list = [12.0,13.0,8.0,9.0,11.5,17.0,10.0,9.0,10.0,13.5,18.0]

num_items :: [Float] -> Int
num_items [] = 0
num_items (x:xs) = 1 + num_items xs

sum_list :: [Float] -> Float
sum_list [] = 0
sum_list (x:xs) = x + sum_list xs

average :: [Float] -> Float
average x = total / numbers
    where
        total = sum_list my_list
        numbers = fromIntegral (num_items my_list) :: Float

variance :: [Float] -> Float
variance x = numbers_sum / numbers
    where
        ave = average my_list
        numbers_sum = sum_list (map (\x -> (x - ave) ^ 2) my_list)
        numbers = fromIntegral (num_items my_list) :: Float

displayStat :: [Float] -> IO ()
displayStat my_list = do
    let average x = total / numbers
    let ma_dev x = numbers_sum_abs / numbers
    let variance x = numbers_sum / numbers
    let std_dev x = sqrt $ var

    putStr ("List of Values:          ")
    putStrLn $ show $ my_list
     
    putStr ("Count:                   ")
    putStrLn $ show $ num_items my_list

    putStr ("Average:                 ")
    putStrLn $ show $ average my_list

    putStr ("Mean Abs. Deviation:     ")
    putStrLn $ show $ ma_dev my_list

    putStr ("Standard Deviation:      ")
    putStrLn $ show $ std_dev my_list

    putStr ("Variance:                ")
    putStrLn $ show $ (variance my_list)

    where
        var = variance my_list
        total = sum_list my_list
        ave = average my_list
        numbers_sum_abs = sum_list (map (\x -> abs(x - ave)) my_list)
        numbers_sum = sum_list (map (\x -> (x - ave) ^ 2) my_list)
        numbers = fromIntegral (num_items my_list) :: Float

main :: IO ()
main = do
    displayStat my_list
    

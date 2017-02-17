--Benjamin Deregnaucourt  Samuel Moulard
--Q3
sommeDeXaY :: Int -> (Int -> Int)
sommeDeXaY x y = if x>y then 0 else sommeDeXaY (x+1) y + x


--Q4
somme [] = 0
somme (x:xs) = somme xs + x

--Q5
last2 :: [a] -> a
last2 xs = head(reverse xs)

init2 :: [a] -> [a]
init2 xs = reverse(tail (reverse xs))

--Q6
sP :: [a] -> Int -> a
sP (x:xs) 0 = x
sP (x:xs) n = sP xs (n-1)

sAdd :: [a] -> [a] -> [a]
sAdd [] xs = xs
sAdd xs [] = xs
sAdd (x:xs) ys = x : sAdd xs ys

concat2 :: [[a]] -> [a]
concat2 [x] = x
concat2 (x:xs) = sAdd x (concat2 xs)

map2 :: (a -> b) -> [a] -> [b]
map2 f [x] = [f x]
map2 f (x:xs) = f x : map2 f xs

--Q7
--x = (!!) l
--ici !! est utilisé comme une fonction 
--Cette déclaration signifie que x prend un entier i en parametre et renvoie le ieme element de la liste l

--Q8

le1 :: a -> Int
le1 x = 1

length2 :: [a] -> Int
length2 [x] = 1
length2 xs = sum (map le1 xs)

--Q9

mTM :: (a -> a) -> a -> Int ->[a]

mTM f x 0 = [x]
mTM f x n = take (n+1) (iterate f x)



mTM2 :: (a -> a) -> a -> Int -> [a]
mTM2 f x 0 = [x]
mTM2 f x n = x : mTM2 f (f x) (n - 1)

count :: (a -> a) -> a -> Int ->[a]
count x = mTM2 (\y -> y+1) x 0

--Q10

list :: Int -> [Int]
list 0 = []
list n = construct plusUn 0 n

plusUn :: Int -> Int
plusUn x = x + 1


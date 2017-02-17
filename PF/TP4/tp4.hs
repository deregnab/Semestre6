import Test.QuickCheck

--Q1
data Arbre coul val = Feuille | Noeud coul val (Arbre coul val) (Arbre coul val)
                     deriving (Show)

--Q2

mapArbre:: (a->b)-> Arbre c a -> Arbre c b
mapArbre _ Feuille = Feuille
mapArbre f (Noeud coul val gauche droite) = Noeud coul (f val) (mapArbre f gauche) (mapArbre f droite)

--Q3

hauteur:: Arbre coul val -> Int
hauteur Feuille = 0
hauteur (Noeud _ _ gauche droite) = 1 + max (hauteur gauche) (hauteur droite)

taille:: Arbre coul val -> Int
taille Feuille = 0
taille (Noeud _ _ gauche droite)= 1 +(taille gauche)+(taille droite)


--Q4
dimension:: (Int -> Int -> Int) -> Arbre coul val -> Int
dimension _ Feuille = 0
dimension f (Noeud coul val gauche droite ) = 1 + f ( dimension f gauche) (dimension f droite)

hauteur2:: Arbre coul val -> Int
hauteur2 = dimension max

taille2:: Arbre coul val -> Int
taille2 = dimension (+) 


--Q5
peigneGauche :: [(coul,val)] -> Arbre coul val

peigneGauche [] = Feuille
peigneGauche ((coul,val):xs) = Noeud coul val (peigneGauche xs) Feuille


--Q6
prop_hauteurPeigne xs = length xs == hauteur (peigneGauche xs)
--Verifie que la longueur du peigne est identique à la longueur de la liste

prop_taillePeigne xs = length xs == taille(peigneGauche xs)
prop_taillePeigne2 xs = length xs == taille2(peigneGauche xs)


--Q8
estComplet :: Arbre coul val -> Bool
estComplet Feuille = True
estComplet (Noeud _ _ gauche droite) = estComplet gauche && estComplet droite && (hauteur gauche == hauteur droite)

--Q9

--estVraimentComplet :: Arbre c v -> Bool
--estVraimentComplet arb@(Noeud _ _ leftTree rightTree) = (hauteur arb) == 1 && (taille leftTree = taille rightTree)

--Q10


--Q11
complet :: Int -> [(c, a)] -> Arbre c a
complet 0 _ = Feuille
complet _ [] = error "Pas assez d'élément dans le tableau"
complet x t = Noeud c v (complet (x-1) s1) (complet (x-1) s2)
         where (s1, ((c,v):s2)) = splitAt (length t `quot` 2) t

--Q12

pasDeFinLOL:: a ->[a]
pasDeFinLOL x = iterate (\x -> x) x

--Q13

pasDeFinV2 :: [((),Char)]
pasDeFinV2 = foldr(\x y -> ((),x) : y)[]['a'..]

--Q14

aplatit :: Arbre c a -> [(c, a)]
aplatit Feuille = []
aplatit (Noeud c a g d) = aplatit g ++ [(c, a)] ++ aplatit d

--Q15
element :: Eq a => a -> Arbre c a -> Bool
element _ Feuille = False
element a (Noeud _ v g d) = (v == a) || (element a g) || (element a d)


--Q16
noeud :: (c -> String) -> (a -> String) -> (c,a) -> String
noeud fc fa(c,a) =(fa a) ++ "[color = "++(fc c) ++", fontcolor = " ++ (fc c) ++"]"

--Q17
arcs :: Arbre c a -> [(a,a)]
arcs Feuille =[]
arcs (Noeud _ _ Feuille Feuille) = []
arcs (Noeud _ h arb@(Noeud _ b _ _) Feuille)= (h, b):(arcs arb)
arcs (Noeud _ h Feuille arb@(Noeud _ b _ _))= (h, b):(arcs arb)
arcs (Noeud _ h arb1@(Noeud _ b1 _ _) arb2@(Noeud _ b2 _ _))= [(h, b1),(h, b2)] ++ (arcs arb1) ++ (arcs arb2)

--Q18
arc :: (a -> String) -> (a,a) -> String
arc f (a,b) = (f a) ++ " -> " ++ (f b)

--Q19

dotise :: String -> (c -> String) -> (a -> String) -> Arbre c a -> String
dotise t fc fv arb@(Noeud c a fg fd)=
    unlines(
        ["digraph  \""++ t ++"\" { node [fontname=\"DejaVu-Sans\", shape=square]"]
        ++ (map (noeud fc fv) (aplatit arb))
        ++ (map (arc fv) (arcs arb))
        ++ ["}"]
    )

--Q20


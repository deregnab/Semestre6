<<<<<<< HEAD
--Benjamin Deregnaucourt Samuel Moulard

import Parser
import Data.Maybe
=======
--Auteurs : Thomas Houset | Yann Garbé

import ./PF/TP5/Parser
import Data.Maybe
import Data.Either
>>>>>>> 022ecc5761439610b3f89e1f1dd072ebe7550fd5
type Nom = String

data Expression = Lam Nom Expression
		| App Expression Expression
		| Var Nom
		| Lit Litteral
		deriving (Show, Eq)

data Litteral = Entier Integer
		| Bool Bool
		deriving (Show, Eq)

--Analyse Proprement Dite

--Question 1
espacesP :: Parser ()
<<<<<<< HEAD
espacesP =  (car ' ' >>= \_ -> espacesP) <|> pure ()

=======
--espacesP =  (car ' ' >>= \_ -> espacesP) <|> pure ()
espacesP =many (car ' ') >> pure ()
>>>>>>> 022ecc5761439610b3f89e1f1dd072ebe7550fd5
--Question 2
isLetter :: Char -> Bool
isLetter c = elem c ['a' .. 'z']

--"some" doit réussir au moins une fois, puis continue jusqu'à un échec
--"many" continue jusqu'à un échec, (ici il renvoie un chaîne vide au premier échec)
nomP :: Parser Nom
nomP =  (some (carQuand isLetter) >>= \c -> espacesP >>= \_ ->  pure c)

--Question 3
varP :: Parser Expression
varP = (nomP >>= \s -> pure (Var s) ) 

--Question 4
applique :: [Expression] -> Expression
applique (x:[]) = x
applique (x1:x2:[]) = App x1 x2
applique (x1:x2:xs) = App ( App x1 x2) (applique xs)

--Question 5 (7, 8 et 10)
exprP :: Parser Expression
exprP = varP 
	<|> lambdaP
	<|> exprParentheseeP
	<|> nombreP
	<|> booleenP

exprsP :: Parser Expression
exprsP = (some (espacesP >> exprP) >>= \e -> pure (applique e))

--Question 6
lambdaP :: Parser Expression
<<<<<<< HEAD
lambdaP = (car '\\' 	 	 	 >>= \_ 
		   -> espacesP 	 	 >>= \_
		   -> chaine "x ->"  	 >>= \_ 
		   -> espacesP 	 	 >>= \_ 
		   -> exprsP 		 >>= \e
		   -> pure (Lam "x" e) )
=======
lambdaP = (car '\\' 	 	 	    >>= \_ 
		   -> espacesP 	 	    >>= \_
		   -> unCaractereQuelconque >>= \c
		   -> espacesP		    >>= \_
		   -> chaine "->"  	    >>= \_ 
		   -> espacesP 	 	    >>= \_ 
		   -> exprsP 		    >>= \e
		   -> pure (Lam [c] e) )
>>>>>>> 022ecc5761439610b3f89e1f1dd072ebe7550fd5

--Question 8 
exprParentheseeP :: Parser Expression
exprParentheseeP = (car '('    >>= \_ 
<<<<<<< HEAD
					-> exprP   >>= \e 
=======
					-> exprsP   >>= \e 
>>>>>>> 022ecc5761439610b3f89e1f1dd072ebe7550fd5
					-> car ')' >>= \_ 
					-> pure e)

--Question 9
isNumber :: Char -> Bool
isNumber a = elem a ['0' .. '9'] 

nombreP :: Parser Expression
nombreP = (some (carQuand isNumber) 			>>= \i
		  -> espacesP				>>= \_
		  -> pure (Lit (Entier (read i))) )

--Question 10
booleenP :: Parser Expression
booleenP = (chaine "True" <|> chaine "False" >>= \s
			-> espacesP	     >>= \_
			-> pure (Lit (Bool (s == "True"))) )

--Question 11
expressionP :: Parser Expression
expressionP = (espacesP  >>= \_
			   -> exprsP >>= \e 
			   -> pure e)

--Question 12
isFinished :: Resultat a -> Bool
isFinished (Just (_, "")) = True
isFinished _ 			  = False

ras :: String -> Expression
ras s = case runParser expressionP s of
          Nothing                           		    -> error "Erreur d’analyse syntaxique"
          exp@(Just (e,_)) | (isFinished exp) == False      -> error "Analyse non terminée"
                           | otherwise        		    -> e

--Interpretation

--Preliminaires
data ValeurA = VLitteralA Litteral
		| VFonctionA (ValeurA -> ValeurA)
		--deriving Show

--Question 13
--Il ne sait pas afficher (ValeurA -> ValeurA)

--Question 14
instance Show ValeurA where
	show (VFonctionA _) = "λ"
	show (VLitteralA (Entier i))= show i 
	show (VLitteralA (Bool b))= show b

type Environnement a = [(Nom, a)]

--Question 15
interpreteA :: Environnement ValeurA -> Expression -> ValeurA
interpreteA _ (Lit e) = VLitteralA e
interpreteA envi (Var e) = fromJust (lookup e envi) 
interpreteA envi (Lam n e) = VFonctionA (\x -> interpreteA ((n, x):envi) e)
interpreteA envi (App e1 e2) = f v
			where VFonctionA f = interpreteA envi e1
			      v = interpreteA envi e2

--Question 16
<<<<<<< HEAD

negA :: ValeurA
negA = VFonctionA negA'

negA':: ValeurA -> ValeurA
negA' (VLitteralA (Entier i)) = VLitteralA (Entier (-1*i))

--Question 17

addA :: ValeurA
addA = VFonctionA addA'
addA' :: ValeurA -> ValeurA -> ValeurA
addA' (VLitteralA (Entier i)) (VLitteralA (Entier j)) = VLitteralA (Entier (i+j))

--Question 18
 
=======
negA :: ValeurA
negA = VFonctionA negA'

negA' :: ValeurA -> ValeurA
negA' (VLitteralA (Entier i)) = VLitteralA (Entier (-1*i))

--Question 17
addA :: ValeurA
addA = VFonctionA addA'

addA':: ValeurA -> ValeurA
addA' (VLitteralA (Entier i)) = VFonctionA (addA'' i)

addA'' :: Integer -> ValeurA -> ValeurA
addA'' a (VLitteralA (Entier j)) = VLitteralA(Entier (a+j))




--Question 18

releveBinOpEntierA :: (Integer -> Integer -> Integer) -> ValeurA
releveBinOpEntierA op = VFonctionA (releveBinOpEntierA' op)

releveBinOpEntierA' :: (Integer -> Integer -> Integer) -> ValeurA -> ValeurA
releveBinOpEntierA' op (VLitteralA (Entier i)) = VFonctionA (releveBinOpEntierA'' op i)

releveBinOpEntierA'' :: (Integer -> Integer -> Integer) -> Integer -> ValeurA -> ValeurA
releveBinOpEntierA'' op a (VLitteralA (Entier j)) = VLitteralA(Entier ( (op a j) ))

envA :: Environnement ValeurA
envA = [ ("neg",   negA)
       , ("add",   releveBinOpEntierA (+))
       , ("soust", releveBinOpEntierA (-))
       , ("mult",  releveBinOpEntierA (*))
       , ("quot",  releveBinOpEntierA quot) ]

--Question 19
ifthenelseA :: ValeurA
ifthenelseA = VFonctionA (inthenelseA' b i)

ifthenelseA :: ValeurA
ifthenelseA = VFonctionA f
            where f (VLitteralA (Bool x)) = VFonctionA g
                    where g (VLitteralA y) = VFonctionA h
                            where h (VLitteralA z) = VLitteralA (if x then y else z)



--Question 20


--Question 21

data ValeurB = VLitteralB Litteral
             | VFonctionB (ValeurB -> ErrValB)

type MsgErreur = String
type ErrValB   = Either MsgErreur ValeurB
interpreteB :: Environnement ValeurB -> Expression -> Maybe ValeurB

--Meme principe que pour la question concernant le Show de interpreteA
instance Show ValeurB where
    show (VFonctionB _)          = "λ"
    show (VLitteralB (Entier n)) = show n
    show (VLitteralB (Bool n))   = show n

--Question 22

interpreteB :: Environnement ValeurB -> Expression -> ErrValB

interpreteB _ (Lit e) = Right (VLitteralA e)
interpreteB env (Var e)   = case lookup e env of
                                    Nothing -> Left 
                                    Just x  -> Right x 
interpreteB envi (Lam n e) =Right( VFonctionB (\x -> interpreteA ((n, x):envi) e))
interpreteB envi (App e1 e2) = f v
			where VFonctionA f = interpreteA envi e1
			      v = interpreteA envi e2

--Question 23
addB :: ValeurB
addB =Right (VFonctionB addB')

addB':: ValeurB -> ValeurB
addB' (VLitteralB (Entier i)) = Right(VFonctionB (addB'' i))
addB' e = Left ("Erreur d'Interpretation 2eme entier attendu, (show e) trouvé")

addB'' :: Integer -> ValeurB -> ValeurB
addB'' a (VLitteralB (Entier j)) = Right(VLitteralB(Entier (a+j)))
addB' e = Left ("Erreur d'Interpretation 1er entier attendu, (show e) trouvé ")

--Question 24

quotB :: ValeurB
quotB =Right (VFonctionB addB')

quotB':: ValeurB -> ValeurB
quotB' (VLitteralB (Entier i)) = Right(VFonctionB (quotB'' i))
quotB' e = Left ("Erreur d'Interpretation 2eme entier attendu, (show e) trouvé")

quotB'' :: Integer -> ValeurB -> ValeurB
quotB'' a (VLitteralB (Entier j)) = Right(VLitteralB(Entier (a/j)))
quotB'' a (VLitteralB (Entier 0)) = Left ("Erreur division par 0")
quotB' e = Left ("Erreur d'Interpretation 1er entier attendu, (show e) trouvé ")


--Question 25

data ValeurC = VLitteralC Litteral
             | VFonctionC (ValeurC -> OutValC)

type Trace   = String
type OutValC = (Trace, ValeurC)

show (VFonctionC _)          = "λ"
show (VLitteralC (Entier n)) = show n
show (VLitteralC (Bool n))   = show n

--Question 26
--interpreteC

--Question 27
--pingC :: ValeurC
>>>>>>> 022ecc5761439610b3f89e1f1dd072ebe7550fd5

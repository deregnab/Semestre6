--Auteurs : Thomas Houset | Yann Garbé

import Parser
import Data.Maybe
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
espacesP =  (car ' ' >>= \_ -> espacesP) <|> pure ()

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
lambdaP = (car '\\' 	 	 	 >>= \_ 
		   -> espacesP 	 	 >>= \_
		   -> chaine "x ->"  	 >>= \_ 
		   -> espacesP 	 	 >>= \_ 
		   -> exprsP 		 >>= \e
		   -> pure (Lam "x" e) )

--Question 8 
exprParentheseeP :: Parser Expression
exprParentheseeP = (car '('    >>= \_ 
					-> exprP   >>= \e 
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

negA :: ValeurA
negA = VFonctionA (*(-1))

import Data.Maybe
import System.IO


data Tree = Node String [(String, Tree)]

instance Show Tree where
    show t = show' 0 t
        where
            show' n (Node x asts) = nSpaces n ++ x ++ "\n" ++ (show'' (n+2) asts)
            show'' _ [] = ""
            show'' n ((arc, t):asts) = nSpaces n ++ arc ++ "\n" ++ (show' (n+2) t) ++ (show'' n asts)
            nSpaces n = foldl (\x _ -> ' ':x) "" [1..n]


numArcs :: Tree -> Int
    -- return the number of arcs of a tree

numArcs (Node _ []) = 0
numArcs (Node _ asts) = (length asts) + foldl (+) 0 (map numArcs (map snd asts))


height :: Tree -> Int
    -- return height of a tree

height (Node _ []) = 1
height (Node _ asts) = 1 + m
    where
        m = foldl max (head l) (tail l)
        l = map height (map snd asts)


type Code = Char
type Column = [Code]
type Matrix = [Column]
type Name = String
type Header = [Name]
type DataFrame = (Header, Matrix)
type Dictionary = (Code, Name)


transpose :: [[a]] -> [[a]]
    -- return matrix transposed

transpose matrix = fmap (\i -> getColumn i matrix) [0..n]
    where
        n = (length (matrix !! 0)) - 1


getColumn :: Int -> [[a]] -> [a]
    -- return i-th column of matrix

getColumn i matrix = map (!!i) matrix


unique :: Eq a => [a] -> [a]
    -- return unique values of list

unique list = unique' list []
    where
        unique' [] uniqueValues = uniqueValues
        unique' (x:xs) uniqueValues
            | elem x uniqueValues = unique' xs uniqueValues
            | otherwise = unique' xs (x:uniqueValues)


remove :: Int -> [a] -> [a]
    -- remove i-th element of l

remove i l = l1 ++ l2
    where
        (l1, (_:l2)) = splitAt i l


myLookup :: Name -> Code -> Name
    -- return the name associated to code in the attribute with name attributeName

myLookup attributeName code = fromMaybe (code : "") name
    where
        name = do
            dic <- lookup attributeName dics
            lookup code dic


dics :: [(Name, [Dictionary])]
    -- return a pair of attributes names and dictionaries to translate their codes

dics = zip names dcs
    where
        dcs = dcs0 ++ dcs1
        dcs0 = d0 : d1 : d2 : d3 : d4 : d5 : d6 : d7 : d8 : d9 : d10 : d11 : []
        dcs1 = d12 : d13 : d14 : d15 : d16 : d17 : d18 : d19 : d20 : d21 : d22 : []
        d0 = [('e', "edible"), ('p', "poisonous")]
        d1 = zip ['b', 'c', 'x', 'f' ,'k', 's'] ["bell", "conical", "convex", "flat", "knobbed", "sunken"]
        d2 = zip ['f', 'g', 'y', 's'] ["fibrous", "grooves", "scaly", "smooth"]
        d3 = zip ['n', 'b', 'c', 'g', 'r', 'p', 'u', 'e', 'w', 'y'] ["brown", "buff", "cinnamon", "gray", "green", "pink", "purple", "red", "white", "yellow"]
        d4 = zip ['t', 'f'] ["bruises", "no"]
        d5 = zip ['a', 'l', 'c', 'y', 'f', 'm', 'n', 'p', 's'] ["almond", "anise", "creosote", "fishy", "foul", "musty", "none", "pungent", "spicy"]
        d6 = zip ['a', 'd', 'f', 'n'] ["attached", "descending", "free", "notched"]
        d7 = zip [ 'c', 'w', 'd'] ["close", "crowded", "distant"]
        d8 = zip ['b', 'n'] ["broad", "narrow"]
        d9 = zip ['k', 'n', 'b', 'h', 'g', 'r', 'o', 'p', 'u', 'e', 'w', 'y'] ["black", "brown", "buff", "chocolate", "gray", "green", "orange", "pink", "purple", "red", "white", "yellow"]
        d10 = zip ['e', 't'] ["enlarging", "tapering"]
        d11 = zip ['b', 'c', 'u', 'e', 'z', 'r', '?'] ["bulbous", "club", "cup", "equal", "rhizomorphs", "rooted", "missing"]
        d12 = zip ['f', 'y', 'k', 's'] ["fibrous", "scaly", "silky", "smooth"]
        d13 = zip ['f', 'y', 'k', 's'] ["fibrous", "scaly", "silky", "smooth"]
        d14 = zip ['n', 'b', 'c', 'g', 'o', 'p', 'e', 'w', 'y'] ["brown", "buff", "cinnamon", "gray", "orange", "pink", "red", "white", "yellow"]
        d15 = zip ['n', 'b', 'c', 'g', 'o', 'p', 'e', 'w', 'y'] ["brown", "buff", "cinnamon", "gray", "orange", "pink", "red", "white", "yellow"]
        d16 = zip ['p', 'u'] ["partial", "universal"]
        d17 = zip ['n', 'o', 'w', 'y'] ["brown", "orange", "white", "yellow"]
        d18 = zip ['n', 'o', 't'] ["none", "one", "two"]
        d19 = zip ['c', 'e', 'f', 'l', 'n', 'p', 's', 'z'] ["cobwebby", "evanescent", "flaring", "large", "none", "pendant", "sheathing", "zone"]
        d20 = zip ['k', 'n', 'b', 'h', 'r', 'o', 'u', 'w', 'y'] ["black", "brown", "buff", "chocolate", "green", "orange", "purple", "white", "yellow"]
        d21 = zip ['a', 'c', 'n', 's', 'v', 'y'] ["abundant", "clustered", "numerous", "scattered", "several", "solitary"]
        d22 = zip ['g', 'l', 'm', 'p', 'u', 'w', 'd'] ["grasses", "leaves", "meadows", "paths", "urban", "waste", "woods"]


names :: [Name]
    -- return the names of each column of agaricus-lepiota

names = m1 ++ m2 ++ m3 ++ m4 ++ m5
    where
        m1 = ["target", "cap-shape", "cap-surface", "cap-color", "bruises?", "odor"]
        m2 = ["gill-attachment", "gill-spacing", "gill-size", "gill-color", "stalk-shape"]
        m3 = ["stalk-root", "stalk-surface-above-ring", "stalk-surface-below-ring"]
        m4 = ["stalk-color-above-ring", "stalk-color-below-ring", "veil-type", "veil-color"]
        m5 = ["ring-number", "ring-type","spore-print-color","population", "habitat"]


buildDT :: DataFrame -> Tree
    -- return a decision tree generated from a data frame. The first column is the target

buildDT (header, target:[])
    | numberOfUniques == 1 = (Node (myLookup (head header) (head target)) [])
    | otherwise = (Node "NO ATTRIBUTES" [])
        where
            numberOfUniques = length $ unique target
buildDT df@(header, (target:attributes))
    | numberOfUniques == 1 = (Node (myLookup (head header) (head target)) [])
    | otherwise = (Node nameOfBest arcsNtrees)
        where
            numberOfUniques = length $ unique target
            evals = evaluateAttributes target attributes
            evalsNidxs = zip evals [0..(length evals - 1)]
            (_, iBest) = foldl max (head evalsNidxs) (tail evalsNidxs)
            nameOfBest = header !! (iBest + 1)
            (arcs, dfs) = splitByClassesOfAttribute df (iBest + 1)
            trees = map buildDT dfs
            arcsNtrees = zip arcs trees


evaluateAttributes :: Column -> Matrix -> [Float]
    -- return the evaluation of each attribute with respect to target

evaluateAttributes target attributes = map (\a -> evaluateAttribute target a) attributes


evaluateAttribute :: Column -> Column -> Float
    -- return the evaluation of attribute with respect to target

evaluateAttribute target attribute = (fromIntegral sum) / (fromIntegral $ length attribute)
    where
        sum = foldl (+) 0 modeOfClassesOfAttribute
        modeOfClassesOfAttribute = map (modeOfClass target attribute) classes
        classes = unique attribute


modeOfClass :: Column -> Column -> Code -> Int
    -- returns the frequency of the most repeated value in target of each class of attribute

modeOfClass target attribute code = mode
    where
        targetFiltered = map fst $ filter (\(t, c) -> c == code) (zip target attribute)
        classesOfTarget = unique targetFiltered
        elementsOfClasses = map (\c -> length $ filter (==c) targetFiltered) classesOfTarget
        mode = foldl max 0 elementsOfClasses


splitByClassesOfAttribute :: DataFrame -> Int -> ([Name], [DataFrame])
    -- return data split by the classes of i-th attribute and their names

splitByClassesOfAttribute (header, dades) index = (arcs, dfs)
    where
        arcs = map (myLookup nameOfAttribute) classes
        nameOfAttribute = header !! index
        attribute = dades !! index
        classes = unique attribute
        withoutAttribute = remove index dades
        header' = remove index header
        dfs = map (\c -> (header', selectByClassOfAttribute attribute withoutAttribute c)) classes


selectByClassOfAttribute :: Column -> Matrix -> Code -> Matrix
    -- return the samples where the value of attribute is code

selectByClassOfAttribute attribute dades classCode = map selectByClassOfAttribute' dades
    where
        selectByClassOfAttribute' = (\dd -> map fst $ filter (\(d, a) -> a == classCode) (zip dd attribute))


readData :: FilePath -> IO Matrix
    -- reads a file and returns the contents of the file as a matrix

readData filePath = do
    content <- readFile filePath
    let rows = map (filter (/= ',')) $ lines content
    let columns = transpose rows
    return columns


showStringList :: [String] -> String
    -- return a string representation of a string list without "" around its elements

showStringList stringList = '[' : (showStringList' stringList) ++ "]"
    where
        showStringList' [] = ""
        showStringList' [s] = s
        showStringList' (s:l) = s ++ ", " ++ (showStringList' l)


makePrediction :: Tree -> IO()
    -- interactive function that makes a prediction using a decision tree

makePrediction (Node prediction []) = do
    putStrLn $ "<system> Prediction: " ++ prediction
    return ()
makePrediction tree@(Node n arcsNtrees) = do
    let options = map fst arcsNtrees
    putStrLn $ "<system> Which " ++ n ++ "? " ++ (showStringList options)
    putStr "<user> "
    hFlush stdout
    option <- getLine
    let maybeNextTree = lookup option arcsNtrees
    if isNothing maybeNextTree then do
        putStrLn "<system> Invalid option. Try again."
        makePrediction tree
    else do
        let nextTree = fromJust maybeNextTree
        makePrediction nextTree


main :: IO()

main = do
    let file = "agaricus-lepiota.data"
    d <- readData file
    let df = (names, d)
    let dt = buildDT df
    makePrediction dt
using DataFrames
using CSV
using StringDistances

df = CSV.read("/Users/euclid/projects/ecolumix/epa/src/analysis/parent_co_level_data.csv")

parents_arr = df[:, 2]

parents_arr[ismissing.(parents_arr)] .= ""

findall("3M", parents_arr, Levenshtein(); min_score = 0.8)

function candidates(s, itr, sdist, min_score) 
    idxs = findall(s, itr, sdist, min_score = min_score)
    itr[idxs]
end 


candidates("3M", parents_arr, Winkler(Jaro()), 0.99)           # upper bound
candidates("3M", parents_arr, Winkler(Jaro()), 0.75)           # lower bound

candidates("A O SMITH", parents_arr, Winkler(Jaro()), 0.86)    # upper bound 
candidates("A O SMITH", parents_arr, Winkler(Jaro()), 0.77)    # lower bound 

candidates("A O SMITH", parents_arr, Jaccard(2), 0.99)         # upper bound 
candidates("A O SMITH", parents_arr, Jaccard(2), 0.31)         # lower bound 

candidates("A O SMITH", parents_arr, Overlap(2), 0.99)         # upper bound
candidates("A O SMITH", parents_arr, Overlap(2), 0.63)         # lower bound

candidates("EXXON MOBIL", parents_arr, Winkler(Jaro()), 0.98)  # upper bound
candidates("EXXON MOBIL", parents_arr, Winkler(Jaro()), 0.75)  # lower bound 


candidates("SAINT-GOBAIN", parents_arr, Winkler(Jaro()), 0.87)    # upper bound
candidates("SAINT-GOBAIN", parents_arr, Winkler(Jaro()), 0.77)    # lower bound

candidates("SAINT-GOBAIN", parents_arr, Overlap(2), 0.77)         # upper bound
candidates("SAINT-GOBAIN", parents_arr, Overlap(2), 0.51)         # lower bound




###
# NOTE: Oldcastle is owned by CRH Americas, both own other 
# so-called parent companies in TRI (e.g., Pike Industries).
###
candidates("OLDCASTLE", parents_arr, Overlap(2), 0.87)    # upper bound
candidates("OLDCASTLE", parents_arr, Overlap(2), 0.63)    # lower bound
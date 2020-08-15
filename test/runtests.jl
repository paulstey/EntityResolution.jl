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


candidates("3M", parents_arr, Winkler(Jaro()), 0.99)

candidates("A O SMITH", parents_arr, Winkler(Jaro()), 0.86)
candidates("A O SMITH", parents_arr, Jaccard(2), 0.86)
candidates("A O SMITH", parents_arr, Overlap(2), 0.99)

candidates("EXXON MOBIL", parents_arr, Winkler(Jaro()), 0.98)  # upper bound
candidates("EXXON MOBIL", parents_arr, Winkler(Jaro()), 0.75)  # lower bound 


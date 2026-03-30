total_pdb=0
total_files=0
total_list=0
total_big=0

echo -e "Full\tFull(+2)\tList\tBig"

for d in {1..9}; do
    PDB_proteins="/hd/PDB_proteins"
    PDB_outputs="/hd/PDB_outputs"

    # count files in /hd/PDB_proteins/<folder>/
    num_pdb=$(ls "$PDB_proteins/$d" 2>/dev/null | wc -l)

    # count files in /hd/PDB_outputs/<folder>/
    num_files=$(ls "$PDB_outputs/$d" 2>/dev/null | wc -l)

    # count lines in /hd/PDB_outputs/<folder>/list.csv (if exists)
    if [[ -f "$PDB_outputs/$d/list.csv" ]]; then
        num_list=$(wc -l < "$PDB_outputs/$d/list.csv")
    else
        num_list=0
    fi

    # count lines in /hd/PDB_outputs/<folder>/big.csv (if exists)
    if [[ -f "$PDB_outputs/$d/big.csv" ]]; then
        num_big=$(wc -l < "$PDB_outputs/$d/big.csv")
    else
        num_big=0
    fi

    echo -e "${num_pdb}\t${num_files}\t${num_list}\t${num_big}"

    # add to totals
    total_pdb=$((total_pdb + num_pdb))
    total_files=$((total_files + num_files))
    total_list=$((total_list + num_list))
    total_big=$((total_big + num_big))
done

# print totals on the last line
echo -e "${total_pdb}\t${total_files}\t${total_list}\t${total_big}"

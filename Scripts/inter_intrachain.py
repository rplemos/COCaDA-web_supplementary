import os
import csv
import sys


def process_contacts_csv(folder_path, ids_file, base_path, big_file, contacts_file, today, database_rerun):

    id_list = []
    big_list = []

    with open(contacts_file, "r") as f:
        intrachain, interchain, total, entries, _  = f.readlines()
        intrachain = int(intrachain.strip())
        interchain = int(interchain.strip())
        total = int(total.strip())
        entries = int(entries.strip())

    print(f"Previous: {intrachain}, {interchain}, {total}, {entries}")

    with open(ids_file, "r") as f:
        for line in f:
            id_list.append(line.strip())

    with open(big_file, "r") as f:
        for line in f:
            big_list.append(line.strip()[0:4])

    for root, dirs, files in os.walk(folder_path):
        for file in files:
            if not file.endswith(".cif"):
                continue
            
            pdb_id = file[0:4].upper()

            if (database_rerun == False) and (pdb_id in id_list or pdb_id in big_list):
                continue
            
            file_path = os.path.join(base_path, pdb_id[0], pdb_id, f"{pdb_id}_contacts.csv")
                            
            try:
                with open(file_path, "r", encoding="utf-8") as csv_file:
                    reader = csv.reader(csv_file)
                    for line in reader:
                        if line[0] == line[4]:
                            intrachain += 1
                        else:
                            interchain += 1
            
                with open(ids_file, "a") as f:
                    f.write(f"{pdb_id}\n")
                            
            except FileNotFoundError:
                if database_rerun:
                    continue
                
                temp_big = f"/hd/cocada-web_update/outputs_temp/outputs_{today}/big.csv"
                with open(temp_big,"r") as f, open(big_file, "a") as g:
                    for line in f:
                        if line.strip().startswith(pdb_id):
                            g.write(line)
                            break

    total = intrachain + interchain
    return intrachain, interchain, total

if __name__ == "__main__":
    folder_path = sys.argv[1]
    num_ids = sys.argv[2]
    today = sys.argv[3]
    update_date = sys.argv[4]
    database_rerun = sys.argv[5]

    ids_file = "/hd/PDB_outputs/id_list.txt"
    big_file = "/hd/PDB_outputs/big.csv"
    base_path = "/hd/PDB_outputs"
    contacts_file = "/hd/PDB_outputs/total_contacts.txt"

    intrachain, interchain, total = process_contacts_csv(folder_path, ids_file, base_path, big_file, contacts_file, today, database_rerun)
    
    # Recalculate num_ids internally (safety check)
    with open(ids_file, "r") as f:
        num_ids_internal = sum(1 for _ in f) 
    
    print(f"Intrachain contacts: {intrachain}")
    print(f"Interchain contacts: {interchain}")
    print(f"Total contacts: {total}")
    print(f"Total entries: {num_ids}/{num_ids_internal}")

    with open(contacts_file, "w") as f:
        f.write(f"{intrachain}\n")
        f.write(f"{interchain}\n")
        f.write(f"{total}\n")
        f.write(f"{num_ids}\n")
        f.write(f"{update_date}\n")

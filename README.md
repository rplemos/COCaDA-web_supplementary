# 🧾 Supplementary files for COCaDA-web
---

This repository contains supplementary materials for the paper **_"COCaDA-web: an interactive web server for exploratory analysis of interatomic contacts in proteins"_**, by **Lemos *et al***.

For the Web Server source code, please visit [COCaDA-web](https://github.com/LBS-UFMG/cocada-web). For the command-line version source code, please visit [COCaDA](https://github.com/LBS-UFMG/cocada).

---

## 📁 Contents

- [`database_weekly_update/`](database_weekly_update/): Contains the scripts for the weekly database update of the Web Server. All scripts are tightly tied to this specific case, and should not be used separately. The workflow is detailed in 
the image below, and in the main text of the paper.
- [`use_case_examples`](use_case_examples/): Contains the raw files used in the two use case examples described in the paper. 
    - 1F41-, 2G2N-, 8UW4-assembly1.cif: Structures of the three experimental proteins used. Only the Biological Assembly 1 for each one was considered (homotetramer);
    - 1F41-, 2G2N-, 8UW4-contacts.csv: Full list of contacts for each protein, identified using COCaDA-web;
    - SupplementaryTableS2.xlsx: Formatted table containing the full list of contacts for each protein (same as CSV files). Contacts discussed in the use case examples are highlighted;
    - use_cases_mapping.pse: PyMOL session used to generate Supplementary Figures S5 and S6.

<img width="821" height="553" alt="Screenshot 2026-03-30 at 10 23 39 am" src="https://github.com/user-attachments/assets/22cc0c81-c6ab-45a2-83d5-9d01f84aba64" alt="workflow"/>

---

## 📄 License
This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

---

## 👤 Contact
For any questions or issues, please contact:

**Rafael P. Lemos**  
PhD Student in Bioinformatics  
Federal University of Minas Gerais  

- 📧 Email: [rafaellemos@ufmg.br](mailto:rafaellemos@ufmg.br)  
- 🔗 GitHub: [@rplemos](https://github.com/rplemos)

---

## 🧠 Contributions and Acknowledgements
 - Prof. Raquel Cardoso de Melo Minardi, UFMG;
 - Prof. Sabrina de Azevedo Silveira, UFV;
 - Dr. Diego Mariano, UFMG;
 - Ana Luísa de Araújo Bastos, UFMG;
 - All the 'Laboratory of Bioinformatics and Systems' team.
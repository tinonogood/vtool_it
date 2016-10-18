*** Settings ***
Library     OperatingSystem
Library     diff
Resource    common_keyword/poscar_keyword.robot
Suite Setup  Directory Should Exist  ${files_dir}

  
*** Variables ***
${files_dir}=  poscar_temple
${contcar_C}=  ${files_dir}/13xH2O_CONT_C
${contcar_D}=  ${files_dir}/13xH2O_CONT_D
${poscar}=  poscar
${C2D_temple}=  ${files_dir}/poscar_temple_C2D
${D2C_temple}=  ${files_dir}/poscar_temple_D2C
${poscar_diff_result}=   poscar_diff
${helper_temple}=  ${files_dir}/poscar_helper_temple
${hint_temple}=  ${files_dir}/poscar_hint_temple


*** Keywords ***

Generate POSCAR From CONTCAR_C
    Run poscar  ${contcar_C}  ${poscar}  

Generate POSCAR From CONTCAR_D
    Run poscar  ${contcar_D}  ${poscar}  
    
Check POSCAR_D
    diff_context  ${poscar}  ${C2D_temple}  ${poscar_diff_result}
    ${rc}  ${result}=  Run and Return RC and Output  cat ${poscar_diff_result}
    Should Be Empty  ${result}
    
Check POSCAR_C
    diff_context  ${poscar}  ${D2C_temple}  ${poscar_diff_result}
    ${rc}  ${result}=  Run and Return RC and Output  cat ${poscar_diff_result}
    Should Be Empty  ${result}

Check poscar Helper
    ${rc}  ${result}=  Run and Return RC and Output  poscar -h
    ${rc}  ${result1}=  Run and Return RC and Output  cat ${helper_temple}
    Should Be Equal  ${result}  ${result1}

Check poscar Hint
    ${rc}  ${result}=  Run and Return RC and Output  poscar
    ${rc}  ${result1}=  Run and Return RC and Output  cat ${hint_temple}
    Should Be Equal  ${result}  ${result1}



*** Test Cases ***
Convert CONTCAR_C To POSCAR
    Test Setup C2D
    Generate POSCAR From CONTCAR_C
    Check POSCAR_D
    Test Teardown  

#Convert CONTCAR_D To POSCAR
#    Test Setup D2C
#    Generate POSCAR From CONTCAR_D
#    Check POSCAR_C
#    Test Teardown 
# 
#Check poscar Helper
#    Test Setup poscar helper
#    Run poscar helpe
#    Check poscar Helper
#
#Check poscar Hint
#    Test Setup poscar hint
#    Run poscar hint
#    Check poscar Hint

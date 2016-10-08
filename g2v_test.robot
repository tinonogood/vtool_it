*** Settings ***
Library     OperatingSystem
Library     diff
Resource    common_keyword/g2v_keyword.robot
Suite Setup  Directory Should Exist  g2v_test_temple  


*** Variables ***
${files_dir}=  g2v_test_temple
${gjf}=  ${files_dir}/13xH2O_CONT.gjf
${poscar}=  13xH2O_CONT_py3
${poscar_temple}=  ${files_dir}/POSCAR_temple
${poscar_diff_result}=   g2v_diff
${helper_temple}=  ${files_dir}/g2v_helper_temple
${hint_temple}=  ${files_dir}/g2v_hint_temple


*** Keywords ***

Generate POSCAR From gjf
    Run g2v  ${gjf}  ${poscar}  
    
Check POSCAR
    diff_context  ${poscar}  ${poscar_temple}  ${poscar_diff_result}
    ${rc}  ${result}=  Run and Return RC and Output  cat ${poscar_diff_result}
    Should Be Empty  ${result}

Check g2v Helper
    ${rc}  ${result}=  Run and Return RC and Output  g2v -h
    ${rc}  ${result1}=  Run and Return RC and Output  cat ${helper_temple}
    Should Be Equal  ${result}  ${result1}

Check g2v Hint
    ${rc}  ${result}=  Run and Return RC and Output  g2v
    ${rc}  ${result1}=  Run and Return RC and Output  cat ${hint_temple}
    Should Be Equal  ${result}  ${result1}



*** Test Cases ***
Convert gjf To POSCAR
    Test Setup gjf To POSCAR
    Generate POSCAR From gjf
    Check POSCAR
    Test Teardown  

Check g2v Helper
    Test Setup gjf To POSCAR helper
    Run g2v helper
    Check g2v Helper

Check g2v Hint
    Test Setup gjf To POSCAR hint
    Run g2v hint
    Check g2v Hint

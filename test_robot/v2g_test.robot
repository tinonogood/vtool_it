*** Settings ***
Library     OperatingSystem
Library     ../util/diff.py
Resource    ../common_keyword/v2g_keyword.robot
Suite Setup  Directory Should Exist  ../pattern/v2g_test_temple  


*** Variables ***
${files_dir}=  ../pattern/v2g_test_temple
${poscar}=  ${files_dir}/13xH2O_CONT
${gjf}=  13xH2O_CONT_py3.gjf
${gjf_temple}=  ${files_dir}/13xH2O_CONT_temple.gjf
${gjf_ABC_temple}=  ${files_dir}/13xH2O_CONT_ABC_temple.gjf
${gjf_diff_result}=   v2g_diff
${helper_temple}=  ${files_dir}/v2g_helper_temple
${hint_temple}=  ${files_dir}/v2g_hint_temple


*** Keywords ***

Generate gjf From POSCAR
    Run v2g  ${poscar}  ${gjf}
    
Generate gjf From POSCAR With Elements Tag
    Run v2g  ${poscar}  ${gjf}  A,B,C
    
Check gjf
    diff_context  ${gjf}  ${gjf_temple}  ${gjf_diff_result}
    ${rc}  ${result}=  Run and Return RC and Output  cat ${gjf_diff_result}
    Should Be Empty  ${result}
    
Check gjf With Elements Tag
    diff_context  ${gjf}  ${gjf_ABC_temple}  ${gjf_diff_result}
    ${rc}  ${result}=  Run and Return RC and Output  cat ${gjf_diff_result}
    Should Be Empty  ${result}

Check gjf Without Output File
    ${rc}  ${result}=  Run and Return RC and Output  v2g -i ${poscar}
    ${rc}  ${result1}=  Run and Return RC and Output  cat ${gjf_temple}
    Should Be Equal  ${result}  ${result1}

Check gjf With Elements Tag Without Output File
    ${rc}  ${result}=  Run and Return RC and Output  v2g -i ${poscar} A,B,C
    ${rc}  ${result1}=  Run and Return RC and Output  cat ${gjf_ABC_temple}
    Should Be Equal  ${result}  ${result1}

Generate v2g Helper  
    Run v2g 

Check v2g Helper
    ${rc}  ${result}=  Run and Return RC and Output  v2g -h
    ${rc}  ${result1}=  Run and Return RC and Output  cat ${helper_temple}
    Should Be Equal  ${result}  ${result1}

Check v2g Hint
    ${rc}  ${result}=  Run and Return RC and Output  v2g
    ${rc}  ${result1}=  Run and Return RC and Output  cat ${hint_temple}
    Should Be Equal  ${result}  ${result1}



*** Test Cases ***
Convert POSCAR To gjf
    [Setup]  File Should Exist  ${gjf_temple}
    Generate gjf From POSCAR
    Check gjf
    [Teardown]  Remove Files  ${gjf}  ${gjf_diff_result}

Convert POSCAR To gjf With Elements Tag
    [Setup]  File Should Exist  ${gjf_ABC_temple}
    Generate gjf From POSCAR With Elements Tag
    Check gjf With Elements Tag
    [Teardown]  Remove Files  ${gjf}  ${gjf_diff_result}

Check v2g Helper
    [Setup]  File Should Exist  ${helper_temple}
    Run v2g helper
    Check v2g Helper

Check v2g Hint
    [Setup]  File Should Exist  ${hint_temple}
    Run v2g hint
    Check v2g Hint

*** Keywords ***
Test Setup C2D
    File Should Exist  ${contcar_C}  ${C2D_temple}

Test Setup D2C
    File Should Exist  ${contcar_D}  ${D2C_temple}

Test Setup poscar helper
    File Should Exist  ${helper_temple}

Test Setup poscar hint
    File Should Exist  ${hint_temple}

Run poscar
    [Arguments]  ${input}=${None}  ${output}=${None}  
    ${cmd}=  Set Variable If
    ...  "${output}" == "${None}"  poscar -i ${input}
#    ...  "${input}" == "${None}"  v2g -h 
    ...  poscar -i ${input} -o ${output}
    ${rc}  ${result}=  Run and Return RC and Output  ${cmd}
    Should Be Equal  ${0}  ${rc}

Run poscar helper
    ${rc}  ${result}=  Run and Return RC and Output  poscar -h
    Should Be Equal  ${0}  ${rc}

Run poscar hint
    ${rc}  ${result}=  Run and Return RC and Output  poscar
    Should Be Equal  ${1}  ${rc}

Test Teardown
    Remove Files  ${poscar}  ${poscar_diff_result}


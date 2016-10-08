*** Keywords ***
Test Setup gjf To POSCAR
    File Should Exist  ${POSCAR_temple}

Test Setup gjf To POSCAR helper
    File Should Exist  ${helper_temple}

Test Setup gjf To POSCAR hint
    File Should Exist  ${hint_temple}

Run g2v
    [Arguments]  ${input}=${None}  ${output}=${None}  ${element_tag}=${None}
    ${cmd}=  Set Variable If
    ...  "${element_tag}" == "${None}"  g2v -i ${input} -o ${output}
    ...  "${output}" == "${None}"  g2v -i ${input}
#    ...  "${input}" == "${None}"  v2g -h 
    ...  v2g -i ${input} -o ${output} -e ${element_tag}
    ${rc}  ${result}=  Run and Return RC and Output  ${cmd}
    Should Be Equal  ${0}  ${rc}

Run g2v helper
    ${rc}  ${result}=  Run and Return RC and Output  g2v -h
    Should Be Equal  ${0}  ${rc}

Run g2v hint
    ${rc}  ${result}=  Run and Return RC and Output  g2v
    Should Be Equal  ${1}  ${rc}

Test Teardown
    Remove Files  ${poscar}  ${poscar_diff_result}


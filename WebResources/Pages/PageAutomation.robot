*** Settings ***
Resource    ../Resource/Resource.robot

*** Variables ***




*** Keywords ***

Recuperer valeur dun element avec prob dinput
    Assign Id To Element    locator    id_for_element
    Execute Javascript    return    document.getElementById("id_for_element").value
    
Verifier que la date est Date J-1
    ${current_date}=    Get Current Date    result_format=%Y-%m-%d
    ${yesterday_date}=    Add Time To Date    ${current_date}    -1 days

La cellule est sur fond jaune
        [Arguments]    ${XPATHCellule}
        Assign Id To Element    ${XPATHCellule}    id_for_color
        ${resultColor}=    Execute Javascript     return window.getComputedStyle(document.getElementById("id_for_color")).getPropertyValue('background-color')
        ${rgb_values}=    Split String    ${resultColor}[4:-1]    ,
        ${r}=    Get From List    ${rgb_values}    0
        ${g}=    Get From List    ${rgb_values}    1
        ${b}=    Get From List    ${rgb_values}    2
        ${hex_value}    Evaluate    '\\#{:02X}{:02X}{:02X}'.format(${r}, ${g}, ${b})
        Should Be Equal As Strings    ${hex_value}    \\#FFF8E5    # FFF8E5 est la couleur jaune

Cliquer sur le bouton export
    ${cheminVersDosstelechargement}=  Creation Path vers Telechargement interne
    Empty Directory    ${cheminVersDosstelechargement}
    # SeleniumLibrary.Wait Until Element Is Visible    ${Button.Export}            ${timeout}
    # SeleniumLibrary.Click Element                    ${Button.Export}

Normalize Value
    [Arguments]    ${value}
    ${value}=    Run Keyword If    '${value}' == 'None'    Set Variable    ''
    ${value}=    Run Keyword If    '${value}' == ''    Set Variable    ''
    [Return]    ${value}
Generation d un fichier EXCEL avec des donnees strictement identiques a celles affichees a l ecran
    ${cheminVersDosstelechargement}=  Creation Path vers Telechargement interne
    Sleep    10s
    Open Excel Document    ${cheminVersDosstelechargement}${/}export.xlsx    0
    ${x}=    Evaluate    0
    FOR    ${ligne}    IN RANGE    1    5
        FOR    ${colonne}    IN RANGE    1    5

            ${valExcel}=    Read Excel Cell    ${ligne}    ${colonne}
            Assign Id To Element  (//span[contains(@data-cy,"example")]//input)[${colonne}]    id_for_value
            ${val}    Execute Javascript    return document.getElementById("id_for_value").value
            ${valExcel}=    Normalize Value    ${valExcel}
            ${val}=    Normalize Value    ${val}
            Should Be Equal As Strings    ${valExcel}    ${val}
        END
        # ${x}=    Evaluate    ${x} + 1
    END
*** Settings ***
Resource    ../resources/common.robot
Library    Cumulocity
Library    DeviceLibrary

Suite Setup    Set Main Device

*** Test Cases ***

Install/remove archive
    ${binary_url}=    Cumulocity.Create Inventory Binary    example    binary    file=${CURDIR}/../testdata/package1.tar.gz
    ${operation}=    Cumulocity.Install Software    {"name": "package1", "version": "1.0.2", "softwareType": "archive", "url": "${binary_url}"}
    Operation Should Be SUCCESSFUL    ${operation}
    Cumulocity.Device Should Have Installed Software    {"name": "package1", "version": "1.0.2", "softwareType": "archive"}
    ${operation}=    Cumulocity.Execute Shell Command    sh -c '[ -x /data/usr/bin/package1 ]'
    Operation Should Be SUCCESSFUL    ${operation}

    # remove
    ${operation}=    Cumulocity.Uninstall Software    {"name": "package1", "version": "1.0.2", "softwareType": "archive"}
    Operation Should Be SUCCESSFUL    ${operation}
    Cumulocity.Device Should Not Have Installed Software    {"name": "package1", "version": "1.0.2", "softwareType": "archive"}

    # File should no longer be there (though the any orphansed folders won't be cleaned up)
    ${operation}=    Cumulocity.Execute Shell Command    sh -c '[ ! -f /data/usr/bin/package1 ]'
    Operation Should Be SUCCESSFUL    ${operation}

*** Keywords ***

Setup
    Set Main Device
    ${operation}=    Cumulocity.Install Software    {"name": "tedge-command-plugin", "version": "latest", "softwareType": "apk"}
    Operation Should Be SUCCESSFUL    ${operation}

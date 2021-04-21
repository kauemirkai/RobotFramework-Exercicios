*** Settings ***
Test Teardown     Close Browser
Resource          resource.robot

*** Test Cases ***
Search by raçao
    Open Browser EX1
    Start Search    Ração
    Click Button    //*[@class="button-search"]
    Wait Until Element Is Visible    //*[@id="produto-href"]
    Click Element    //*[@data-nomeproduto="${PROD1}"]
    Wait Until Element Is Visible    //div[@class='price-current']
    Element Should Contain    //div[@class='price-current']    249,19    Preço incorreto ou não visível.
    Element Should Contain    //h1[contains(text(),'${PROD1}')]    ${PROD1}    Nome do produto incorreto
    Element Should Contain    //span[@class='price-subscriber']    224,27    Preço para assinantes incorreto ou não visível.
    Click Button    //button[@id='adicionarAoCarrinho']
    Wait Until Element Is Visible    //td[@class='td-resumo']
    Element Should Contain    //td[@class='td-resumo']    ${PROD1}    Nome do produto incorreto
    Element Should Contain    //td[@class='preco']    249,19    Preço incorreto ou não visível.
    Click Element    //button[@class='btn btn-sm plus-button-carrinho merge-top-right-button']
    Wait Until Element Contains    //td[@class='total']    498,38

Read CSV file
    ${prod}    CSVLib.Read Csv As List    myfile0.csv
    Open Browser EX1
    FOR    ${prod}    IN    @{prod}
        ${name}    Get From List    ${prod}    0
        ${price}    Get From List    ${prod}    1
        ${partnerprice}    Get From List    ${prod}    2
        log    ${prod}
        log    ${name}
        log    ${price}
        log    ${partnerprice}
        Start Search    ${name}
        Comment    Click Button    //*[@class="button-search"]
        Comment    Wait Until Element Is Visible    //*[@id="produto-href"]
        Comment    Click Element    //*[@data-nomeproduto="${name}"]
        Wait Until Element Is Visible    //div[@class='price-current']
        log    ${price}
        Element Should Contain    //div[@class='price-current']    ${price}    Preço incorreto ou não visível.
        Element Should Contain    //h1[contains(text(),'${name}')]    ${name}    Nome do produto incorreto
        Element Should Contain    //span[@class='price-subscriber']    ${partnerprice}    Preço para assinantes incorreto ou não visível.
        Click Button    //button[@id='adicionarAoCarrinho']
        Wait Until Element Is Visible    //td[@class='td-resumo']
        Element Should Contain    //a[contains(text(),'${name}')]    ${name}    Nome do produto incorreto
        Element Should Contain    //td[@class='preco'][contains(text(),'${price}')]    ${price}    Preço incorreto ou não visível.
    END

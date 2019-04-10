*** Settings ***
Library           Selenium2Library    timeout=30
Library           DateTime
Library           Collections
Library           String
Library           XML
Library           OperatingSystem
Library           BuiltIn
Library           String
Library           Process
Library           Dialogs
Library           Screenshot
Library           Telnet
Library           RequestsLibrary
Library           MyKeyword.py

*** Keywords ***
判断元素个数并包含
    [Arguments]    ${locator}    ${index}=0
    ${number}    evaluate    ${index}+1
    : FOR    ${i}    IN RANGE    50
    \    wait until page contains element    ${locator}    30    page not contains element
    \    @{element}    Get WebElements    ${locator}
    \    ${len}    得到长度    ${element}
    \    Exit For Loop If    ${len} >= ${number}
    Set Focus To Element    @{element}[${index}]
    [Return]    @{element}

判断元素个数并显示
    [Arguments]    ${locator}    ${index}=0
    ${number}    evaluate    ${index}+1
    : FOR    ${i}    IN RANGE    50
    \    wait until page contains element    ${locator}    30
    \    Wait Until Element Is Visible    ${locator}    30
    \    @{element}    Get WebElements    ${locator}
    \    ${len}    得到长度    ${element}
    \    Exit For Loop If    ${len} >= ${number}
    Set Focus To Element    @{element}[${index}]
    [Return]    @{element}

退出驱动
    [Documentation]    退出驱动，自动判断是Window还是Linux环境
    ...    关闭：谷歌、IE、火狐的驱动，防止驱动未关出现问题
    ${addr}    Evaluate    type(pathlib2.Path())    pathlib2
    Run Keyword If    "${addr}" == "<class 'pathlib2.WindowsPath'>"    Win_Kill
    Run Keyword If    "${addr}" == "<class 'pathlib2.PosixPath'>"    Linux_Kill

Win_Kill
    [Documentation]    Window环境中运行完毕后关闭浏览器 的驱动 （ie和谷歌）
    Close All Browsers
    evaluate    os.system('taskkill /f /im IEDriverServer.exe')    os
    evaluate    os.system('taskkill /f /im chromedriver.exe')    os
    evaluate    os.system('taskkill /f /im geckodriver.exe')    os

Linux_Kill
    [Documentation]    Linux环境中运行完毕后关闭谷歌浏览器的驱动
    Close All Browsers
    evaluate    os.system('killall chrome')    os
    evaluate    os.system('killall chromedriver')    os

打开浏览器
    [Arguments]    ${url}    ${browser}=headlesschrome
    [Documentation]    打开浏览器，参数${url}输入的是网址
    ...    参数${browser}：是浏览器类型，默认使用谷歌后台运行
    ...    参数：
    ...    IE浏览器 --- ie
    ...    谷歌浏览器 --- gc
    ...    火狐浏览器 --- ff
    ...    谷歌后台模式 --- headlesschrome
    ...    火狐后台模式 --- headlessfirefox
    Append To Environment Variable    PATH    /usr/local/bin
    open browser    ${url}    ${browser}
    Maximize Browser Window
    reload page

刷新网页
    [Documentation]    刷新网页
    reload page

关闭浏览器
    [Documentation]    关闭浏览器
    sleep    2
    close browser

关闭所有浏览器
    [Documentation]    关闭所有浏览器
    close all browsers
    退出驱动

鼠标悬停
    [Arguments]    ${locator}    ${index}=0
    @{el}    判断元素个数并包含    ${locator}    ${index}
    : FOR    ${i}    IN RANGE    50
    \    ${msg}    Run Keyword And Ignore Error    Mouse Over    @{el}[${index}]
    \    Exit For Loop If    "${msg[0]}" == "PASS"
    RUN KEYWORD IF    "${msg[0]}" == "PASS"    set variable    ${True}
    ...    ELSE IF    "${msg[0]}" == "FAIL"    Mouse Over    @{el}[${index}]

点击元素
    [Arguments]    ${locator}    ${index}=0
    [Documentation]    点击元素。
    ...    参数${locator}：是定位 方式 例如：id=kw
    ...    ${index}是元素索引：当定位是一组元素时候使用
    @{el}    判断元素个数并包含    ${locator}    ${index}
    : FOR    ${i}    IN RANGE    50
    \    ${msg}    Run Keyword And Ignore Error    click element    @{el}[${index}]
    \    Exit For Loop If    "${msg[0]}" == "PASS"
    RUN KEYWORD IF    "${msg[0]}" == "PASS"    set variable    ${True}
    ...    ELSE IF    "${msg[0]}" == "FAIL"    click element    @{el}[${index}]

点击按钮
    [Arguments]    ${locator}    ${index}=0
    [Documentation]    参数${locator}：是定位 方式 例如：id=kw
    ...    ${index}是元素索引：当定位是一组元素时候使用，
    @{el}    判断元素个数并包含    ${locator}    ${index}
    : FOR    ${i}    IN RANGE    50
    \    ${msg}    Run Keyword And Ignore Error    Click Button    @{el}[${index}]
    \    Exit For Loop If    "${msg[0]}" == "PASS"
    RUN KEYWORD IF    "${msg[0]}" == "PASS"    set variable    ${True}
    ...    ELSE IF    "${msg[0]}" == "FAIL"    Click Button    @{el}[${index}]

点击链接
    [Arguments]    ${locator}    ${index}=0
    [Documentation]    参数${locator}：是定位 方式 例如：id=kw
    ...    ${index}是元素索引：当定位是一组元素时候使用，
    @{el}    判断元素个数并包含    ${locator}    ${index}
    : FOR    ${i}    IN RANGE    50
    \    ${msg}    Run Keyword And Ignore Error    Click Link    @{el}[${index}]
    \    Exit For Loop If    "${msg[0]}" == "PASS"
    RUN KEYWORD IF    "${msg[0]}" == "PASS"    set variable    ${True}
    ...    ELSE IF    "${msg[0]}" == "FAIL"    Click Link    @{el}[${index}]

双击
    [Arguments]    ${locator}    ${index}=0
    [Documentation]    参数${locator}：是定位 方式 例如：id=kw
    ...    ${index}是元素索引：当定位是一组元素时候使用，
    @{el}    判断元素个数并包含    ${locator}    ${index}
    : FOR    ${i}    IN RANGE    50
    \    ${msg}    Run Keyword And Ignore Error    double click element    @{el}[${index}]
    \    Exit For Loop If    "${msg[0]}" == "PASS"
    RUN KEYWORD IF    "${msg[0]}" == "PASS"    set variable    ${True}
    ...    ELSE IF    "${msg[0]}" == "FAIL"    double click element    @{el}[${index}]

输入文本
    [Arguments]    ${locator}    ${text}    ${index}=0
    [Documentation]    参数${locator}：是定位 方式，例如：id=kw；
    ...    ${text}是输入的文本；
    ...    ${index}是元素索引：当定位是一组元素时候使用
    @{el}    判断元素个数并包含    ${locator}    ${index}
    : FOR    ${i}    IN RANGE    50
    \    ${msg}    Run Keyword And Ignore Error    input text    @{el}[${index}]    ${text}
    \    Exit For Loop If    "${msg[0]}" == "PASS"
    RUN KEYWORD IF    "${msg[0]}" == "PASS"    set variable    ${True}
    ...    ELSE IF    "${msg[0]}" == "FAIL"    input text    @{el}[${index}]    ${text}

canvas输入文本
    [Arguments]    ${locator}    ${text}    @{size}
    [Documentation]    参数${locator}：是定位 方式，例如：id=kw；
    ...    ${text}是输入的文本；
    ...    @{size}是一个列表：如果canvas是唯一定位，
    ...    传入3个参数【150,10,100】，分别表示：输入字体大小
    ...    、距离左边画板的距离，距离上边画板的距离，
    ...    如果canvas不是唯一定位，传入4个参数【1，150,10,100】
    ...    ，第一个参数为要操作元素的索引值，后3个和上面相同
    ${x}    得到长度    ${size}
    ${index}    BuiltIn.Run Keyword If    ${x} == 3    BuiltIn.Set Variable    0
    ...    ELSE IF    ${x} == 4    BuiltIn.Set Variable    @{size}[0]
    @{el}    判断元素个数并包含    ${locator}    ${index}
    ${name}    evaluate    str(time.time()).replace('.','')    time
    Assign Id To Element    @{el}[${index}]    id_01_${name}    #给canvas标签添加id
    BuiltIn.Run Keyword If    ${x} == 3    Execute Javascript    el=document.querySelector('#id_01_${name}');context=el.getContext("2d");context.fillStyle='#000000';context.font = "bold @{size}[0]px Arial";context.textAlign = "left";context.textBaseline = "middle";context.strokeText("${text}", @{size}[1], @{size}[2]);
    ...    ELSE IF    ${x} == 4    Execute Javascript    el=document.querySelector('#id_01_${name}');context=el.getContext("2d");context.fillStyle='#000000';context.font = "bold @{size}[1]px Arial";context.textAlign = "left";context.textBaseline = "middle";context.strokeText("${text}", @{size}[2], @{size}[3]);

点击radio
    [Arguments]    ${locator}    ${index}=0
    [Documentation]    ${locator}定位；
    ...    参数${locator}:是定位；
    ...    参数${index}：是索引，当得到一组元素时候使用；
    @{el}    判断元素个数并包含    ${locator}    ${index}
    ${time}    evaluate    str(time.time()).replace('.','')    time
    Assign Id To Element    @{el}[${index}]    id_${time}
    Execute Javascript    document.querySelectorAll('#id_${time}')[0].setAttribute('name','radio_${time}')    #新增name的属性，如果有的话进行修改成新的
    Execute Javascript    document.querySelectorAll('#id_${time}')[0].setAttribute('value','radio_${time}')    #新增value的属性，如果有的话进行修改成新的
    : FOR    ${i}    IN RANGE    50
    \    ${msg}    Run Keyword And Ignore Error    select radio button    radio_${time}    radio_${time}
    \    Exit For Loop If    "${msg[0]}" == "PASS"
    RUN KEYWORD IF    "${msg[0]}" == "PASS"    set variable    ${True}
    ...    ELSE IF    "${msg[0]}" == "FAIL"    select radio button    radio_${time}    radio_${time}

点击checkbox
    [Arguments]    ${locator}    ${index}=0
    [Documentation]    点击复选框；参数${locator}：是定位 方式 例如：id=kw
    ...    ${index}是元素索引：当定位是一组元素时候使用
    @{el}    判断元素个数并包含    ${locator}    ${index}
    : FOR    ${i}    IN RANGE    50
    \    ${msg}    Run Keyword And Ignore Error    select checkbox    @{el}[${index}]
    \    Exit For Loop If    "${msg[0]}" == "PASS"
    RUN KEYWORD IF    "${msg[0]}" == "PASS"    set variable    ${True}
    ...    ELSE IF    "${msg[0]}" == "FAIL"    select checkbox    @{el}[${index}]

取消checkbox
    [Arguments]    ${locator}    ${index}=0
    [Documentation]    取消选择复选框；参数${locator}：是定位 方式 例如：id=kw
    ...    ${index}是元素索引：当定位是一组元素时候使用
    @{el}    判断元素个数并包含    ${locator}    ${index}
    : FOR    ${i}    IN RANGE    50
    \    ${msg}    Run Keyword And Ignore Error    unselect checkbox    @{el}[${index}]
    \    Exit For Loop If    "${msg[0]}" == "PASS"
    RUN KEYWORD IF    "${msg[0]}" == "PASS"    set variable    ${True}
    ...    ELSE IF    "${msg[0]}" == "FAIL"    unselect checkbox    @{el}[${index}]

下拉框
    [Arguments]    ${locator}    ${value}    ${index}=0
    [Documentation]    使用标签值选择列表下拉框；
    ...    参数${locator}：是定位 方式；
    ...    参数${value}：是标签option中value的值；
    ...    ${index}是元素索引：当定位是一组元素时候使用；
    @{el}    判断元素个数并包含    ${locator}    ${index}
    : FOR    ${i}    IN RANGE    50
    \    ${msg}    Run Keyword And Ignore Error    select from list by value    @{el}[${index}]    ${value}
    \    Exit For Loop If    "${msg[0]}" == "PASS"
    RUN KEYWORD IF    "${msg[0]}" == "PASS"    set variable    ${True}
    ...    ELSE IF    "${msg[0]}" == "FAIL"    select from list by value    @{el}[${index}]    ${value}

下拉框index
    [Arguments]    ${locator}    ${index_01}    ${index}=0
    [Documentation]    使用索引值选择列表下拉框；
    ...    参数${locator}：是定位 方式；
    ...    参数${index_01}：是标签中的索引的值；
    ...    ${index}是元素索引：当定位是一组元素时候使用；
    @{el}    判断元素个数并包含    ${locator}    ${index}
    : FOR    ${i}    IN RANGE    50
    \    ${msg}    Run Keyword And Ignore Error    select from list by index    @{el}[${index}]    ${index_01}
    \    Exit For Loop If    "${msg[0]}" == "PASS"
    RUN KEYWORD IF    "${msg[0]}" == "PASS"    set variable    ${True}
    ...    ELSE IF    "${msg[0]}" == "FAIL"    select from list by index    @{el}[${index}]    ${index_01}

非标准下拉框
    [Arguments]    ${locator}    ${text}    ${index}=0
    [Documentation]    使用标签值选择列表下拉框；
    ...    参数${locator}：是定位 方式；
    ...    参数${text}：是标签li中的文本值；
    ...    ${index}是元素索引：当li中的文本不唯一时候使用索引值；
    @{el}    判断元素个数并包含    ${locator}    0    #因为第一个定位参数不能默认值，所以只能传入唯一定位
    ${name}    evaluate    str(time.time()).replace('.','')    time
    Assign Id To Element    @{el}[0]    id_01_${name}    #给下拉框标签添加id
    : FOR    ${i}    IN RANGE    50
    \    ${msg}    Run Keyword And Ignore Error    execute javascript    document.querySelector('#id_01_${name}').click()
    \    Exit For Loop If    "${msg[0]}" == "PASS"
    RUN KEYWORD IF    "${msg[0]}" == "PASS"    set variable    ${True}
    ...    ELSE IF    "${msg[0]}" == "FAIL"    execute javascript    document.querySelector('#id_01_${name}').click()
    ${label}    BuiltIn.Set Variable    li
    ${locator}    evaluate    'xpath://{}[contains(string(),"${text}")]'.format("${label}")
    @{el}    判断元素个数并包含    ${locator}    ${index}
    Assign Id To Element    @{el}[${index}]    id_02_${name}    #给li标签添加id
    : FOR    ${i}    IN RANGE    50
    \    ${msg}    Run Keyword And Ignore Error    execute javascript    document.querySelector('#id_02_${name}').click()
    \    Exit For Loop If    "${msg[0]}" == "PASS"
    RUN KEYWORD IF    "${msg[0]}" == "PASS"    set variable    ${True}
    ...    ELSE IF    "${msg[0]}" == "FAIL"    execute javascript    document.querySelector('#id_02_${name}').click()

得到文本
    [Arguments]    ${locator}    ${index}=0
    [Documentation]    得到页面元素的文本；
    ...    参数${locator}是元素的定位
    @{el}    判断元素个数并包含    ${locator}    ${index}
    : FOR    ${i}    IN RANGE    50
    \    ${text}    get text    @{el}[${index}]
    \    ${msg}    Run Keyword And Ignore Error    BuiltIn.Should Not Be Empty    ${text}
    \    Exit For Loop If    "${msg[0]}" == "PASS"
    RUN KEYWORD IF    "${msg[0]}" == "PASS"    set variable    ${True}
    ...    ELSE IF    "${msg[0]}" == "FAIL"    BuiltIn.Should Not Be Empty    ${text}
    [Return]    ${text}

移动滑块
    [Arguments]    ${locator}    ${index}=0
    [Documentation]    点击元素。
    ...    参数${locator}：是定位 方式 例如：id=kw
    ...    ${index}是元素索引：当定位是一组元素时候使用
    @{el}    判断元素个数并包含    ${locator}    ${index}
    : FOR    ${i}    IN RANGE    50
    \    ${msg}    Run Keyword And Ignore Error    Drag And Drop By Offset    @{el}[${index}]    10000    0
    \    Exit For Loop If    "${msg[0]}" == "PASS"
    RUN KEYWORD IF    "${msg[0]}" == "PASS"    set variable    ${True}
    ...    ELSE IF    "${msg[0]}" == "FAIL"    Drag And Drop By Offset    @{el}[${index}]    10000    0

jq点击
    [Arguments]    ${locator}    ${index}=0
    [Documentation]    jq定位是使用jquery定位
    ...    参数${locator}:是定位；
    ...    参数${index}：是索引，当得到一组元素时候使用；
    判断元素个数并包含    ${locator}    ${index}
    ${css}    set variable    ${locator[7:]}
    : FOR    ${i}    IN RANGE    50
    \    ${msg}    Run Keyword And Ignore Error    execute javascript    $('${css}').eq(${index}).click()
    \    Exit For Loop If    "${msg[0]}" == "PASS"
    RUN KEYWORD IF    "${msg[0]}" == "PASS"    set variable    ${True}
    ...    ELSE IF    "${msg[0]}" == "FAIL"    execute javascript    $('${css}').eq(${index}).click()

jq点击文本
    [Arguments]    ${label}    ${text}    ${index}=0
    [Documentation]    使用标签之间的文本来点击元素
    ...    ${label}：是元素便签的名字，例如：a，span，div等
    ...    ${text} ：是元素标签之间的文本
    ...    ${index}：如果得到的是多个元素，输入所需元素的索引
    ${locator}    evaluate    'jquery:{}:contains("${text}")'.format("${label}")
    @{el}    判断元素个数并包含    ${locator}    ${index}
    ${name}    evaluate    str(time.time()).replace('.','')    time
    Assign Id To Element    @{el}[${index}]    id_${name}
    : FOR    ${i}    IN RANGE    50
    \    ${msg}    Run Keyword And Ignore Error    execute javascript    $('#id_${name}').click()
    \    Exit For Loop If    "${msg[0]}" == "PASS"
    RUN KEYWORD IF    "${msg[0]}" == "PASS"    set variable    ${True}
    ...    ELSE IF    "${msg[0]}" == "FAIL"    execute javascript    $('#id_${name}').click()

jq双击
    [Arguments]    ${locator}    ${index}=0
    [Documentation]    jq定位是使用jquery定位
    ...    参数${locator}:是定位；
    ...    参数${index}：是索引，当得到一组元素时候使用；
    判断元素个数并包含    ${locator}    ${index}
    ${css}    set variable    ${locator[7:]}
    : FOR    ${i}    IN RANGE    50
    \    ${msg}    Run Keyword And Ignore Error    execute javascript    $('${css}').eq(${index}).dblclick()
    \    Exit For Loop If    "${msg[0]}" == "PASS"
    RUN KEYWORD IF    "${msg[0]}" == "PASS"    set variable    ${True}
    ...    ELSE IF    "${msg[0]}" == "FAIL"    execute javascript    $('${css}').eq(${index}).dblclick()

jq输入
    [Arguments]    ${locator}    ${text}    ${index}=0
    [Documentation]    jq定位是使用jquery定位
    ...    参数${locator}:是定位；
    ...    参数${index}：是索引，当得到一组元素时候使用；
    ...    参数${text}：是要输入的文本
    判断元素个数并包含    ${locator}    ${index}
    ${css}    set variable    ${locator[7:]}
    : FOR    ${i}    IN RANGE    50
    \    ${msg}    Run Keyword And Ignore Error    execute javascript    $('${css}').eq(${index}).val('${text}')
    \    Exit For Loop If    "${msg[0]}" == "PASS"
    RUN KEYWORD IF    "${msg[0]}" == "PASS"    set variable    ${True}
    ...    ELSE IF    "${msg[0]}" == "FAIL"    execute javascript    $('${css}').eq(${index}).val('${text}')

jq得到文本
    [Arguments]    ${label}    ${text}    ${index}=0
    [Documentation]    使用标签之间的文本来得到文本
    ...    ${label}：是元素便签的名字，例如：a，span，div等
    ...    ${text} ：是元素标签之间的文本
    ...    ${index}：如果得到的是多个元素，输入所需元素的索引
    ${locator}    evaluate    'xpath://{}[contains(text(),"${text}")]'.format("${label}")
    @{el}    判断元素个数并包含    ${locator}    ${index}
    ${name}    evaluate    str(time.time()).replace('.','')    time
    Assign Id To Element    @{el}[${index}]    id_${name}
    : FOR    ${i}    IN RANGE    50
    \    ${text}    execute javascript    return $('#id_${name}').text()
    \    ${msg}    Run Keyword And Ignore Error    BuiltIn.Should Not Be Empty    ${text}
    \    Exit For Loop If    "${msg[0]}" == "PASS"
    RUN KEYWORD IF    "${msg[0]}" == "PASS"    set variable    ${True}
    ...    ELSE IF    "${msg[0]}" == "FAIL"    BuiltIn.Should Not Be Empty    ${text}
    [Return]    ${text}

js点击
    [Arguments]    ${locator}    ${index}=0
    [Documentation]    js定位只能使用css语法；
    ...    参数${locator}:是定位；
    ...    参数${index}：是索引，当得到一组元素时候使用；
    判断元素个数并包含    ${locator}    ${index}
    ${css}    set variable    ${locator[4:]}
    : FOR    ${i}    IN RANGE    50
    \    ${msg}    Run Keyword And Ignore Error    execute javascript    document.querySelectorAll('${css}')[${index}].click()
    \    Exit For Loop If    "${msg[0]}" == "PASS"
    RUN KEYWORD IF    "${msg[0]}" == "PASS"    set variable    ${True}
    ...    ELSE IF    "${msg[0]}" == "FAIL"    execute javascript    document.querySelectorAll('${css}')[${index}].click()

js点击文本
    [Arguments]    ${label}    ${text}    ${index}=0
    [Documentation]    使用标签之间的文本来点击元素
    ...    ${label}：是元素便签的名字，例如：a，span，div等
    ...    ${text} ：是元素标签之间的文本
    ...    ${index}：如果得到的是多个元素，输入所需元素的索引
    ${locator}    evaluate    'xpath://{}[contains(string(),"${text}")]'.format("${label}")
    @{el}    判断元素个数并包含    ${locator}    ${index}
    ${name}    evaluate    str(time.time()).replace('.','')    time
    Assign Id To Element    @{el}[${index}]    id_${name}
    : FOR    ${i}    IN RANGE    50
    \    ${msg}    Run Keyword And Ignore Error    execute javascript    document.querySelector('#id_${name}').click()
    \    Exit For Loop If    "${msg[0]}" == "PASS"
    RUN KEYWORD IF    "${msg[0]}" == "PASS"    set variable    ${True}
    ...    ELSE IF    "${msg[0]}" == "FAIL"    execute javascript    document.querySelector('#id_${name}').click()

js输入
    [Arguments]    ${locator}    ${text}    ${index}=0
    [Documentation]    js定位只能使用css语法；
    ...    参数${locator}:是定位；
    ...    参数${index}：是索引，当得到一组元素时候使用；
    ...    参数${text}：是输入的文本；
    判断元素个数并包含    ${locator}    ${index}
    ${css}    set variable    ${locator[4:]}
    : FOR    ${i}    IN RANGE    50
    \    ${msg}    Run Keyword And Ignore Error    execute javascript    document.querySelectorAll('${css}')[${index}].value='${text}'
    \    Exit For Loop If    "${msg[0]}" == "PASS"
    RUN KEYWORD IF    "${msg[0]}" == "PASS"    set variable    ${True}
    ...    ELSE IF    "${msg[0]}" == "FAIL"    execute javascript    document.querySelectorAll('${css}')[${index}].value='${text}'

js得到文本
    [Arguments]    ${label}    ${text}    ${index}=0
    [Documentation]    使用标签之间的文本来得到所有文本
    ...    ${label}：是元素便签的名字，例如：a，span，div等
    ...    ${text} ：是元素标签之间的文本
    ...    ${index}：如果得到的是多个元素，输入所需元素的索引
    ${locator}    evaluate    'xpath://{}[contains(text(),"${text}")]'.format("${label}")
    @{el}    判断元素个数并包含    ${locator}    ${index}
    ${name}    evaluate    str(time.time()).replace('.','')    time
    Assign Id To Element    @{el}[${index}]    id_${name}
    : FOR    ${i}    IN RANGE    50
    \    ${text}    execute javascript    return document.querySelector('#id_${name}').innerText
    \    ${msg}    Run Keyword And Ignore Error    BuiltIn.Should Not Be Empty    ${text}
    \    Exit For Loop If    "${msg[0]}" == "PASS"
    RUN KEYWORD IF    "${msg[0]}" == "PASS"    set variable    ${True}
    ...    ELSE IF    "${msg[0]}" == "FAIL"    BuiltIn.Should Not Be Empty    ${text}
    [Return]    ${text}

js上传文件
    [Arguments]    ${file_path}    ${index}=0
    [Documentation]    js上传文件
    ...    参数${file_path} ：是要上传文件的地址包括后缀名称
    ...    参数${index}：是索引，当得到一组元素时候使用；
    @{el}    判断元素个数并包含    css:[type="file"]    ${index}
    execute javascript    document.querySelectorAll('[type="file"]')[${index}].style="display: true"
    : FOR    ${i}    IN RANGE    50
    \    ${msg}    Run Keyword And Ignore Error    Choose File    @{el}[${index}]    ${file_path}
    \    Exit For Loop If    "${msg[0]}" == "PASS"
    RUN KEYWORD IF    "${msg[0]}" == "PASS"    set variable    ${True}
    ...    ELSE IF    "${msg[0]}" == "FAIL"    Choose File    @{el}[${index}]    ${file_path}
    execute javascript    document.querySelectorAll('[type="file"]')[${index}].style="display: none;"

div滚动条
    [Arguments]    ${locator}    ${number}    ${index}=0
    [Documentation]    默认上下移动div内嵌式hi滚动条；
    ...    js定位是使用css定位
    ...    参数${locator}:是定位；
    ...    参数${index}：是索引，当得到一组元素时候使用；
    ...    参数${number}：是滚动的位置 ，输入的值，例如：50；
    判断元素个数并包含    ${locator}    ${index}
    ${css}    set variable    ${locator[4:]}
    : FOR    ${i}    IN RANGE    50
    \    ${msg}    Run Keyword And Ignore Error    execute javascript    document.querySelectorAll('${css}')[${index}].scrollTop=${number}
    \    Exit For Loop If    "${msg[0]}" == "PASS"
    RUN KEYWORD IF    "${msg[0]}" == "PASS"    set variable    ${True}
    ...    ELSE IF    "${msg[0]}" == "FAIL"    execute javascript    document.querySelectorAll('${css}')[${index}].scrollTop=${number}

div滚动条left
    [Arguments]    ${locator}    ${number}    ${index}=0
    [Documentation]    默认左右移动div内嵌式hi滚动条；
    ...    js定位是使用css定位
    ...    参数${locator}:是定位；
    ...    参数${number}：是滚动的位置 ，输入的值，例如：50；
    ...    参数${index}：是索引，当得到一组元素时候使用；
    判断元素个数并包含    ${locator}    ${index}
    ${css}    set variable    ${locator[4:]}
    : FOR    ${i}    IN RANGE    50
    \    ${msg}    Run Keyword And Ignore Error    execute javascript    document.querySelectorAll('${css}')[${index}].scrollLeft=${number}
    \    Exit For Loop If    "${msg[0]}" == "PASS"
    RUN KEYWORD IF    "${msg[0]}" == "PASS"    set variable    ${True}
    ...    ELSE IF    "${msg[0]}" == "FAIL"    execute javascript    document.querySelectorAll('${css}')[${index}].scrollLeft=${number}

滚动条
    [Arguments]    ${number}
    [Documentation]    针对整个页面的滚动条；
    ...    参数${number}：是移动的位置，输入数字，例如：500
    execute javascript    document.documentElement.scrollTop=${number}

打开新页面
    [Arguments]    ${url}
    [Documentation]    打开新的网址，参数${url} ：是网址
    execute javascript    window.open('${url}')

切换frame
    [Arguments]    ${locator}    ${index}=0
    [Documentation]    切换到frame框，参数${locator}：是定位方式；
    ...    如果有id和name的话直接写： 两个属性的值即可；
    ...    例如id=kw，name=su，直接写 kw或su即可
    @{el}    判断元素个数并包含    ${locator}    ${index}
    : FOR    ${i}    IN RANGE    50
    \    ${msg}    Run Keyword And Ignore Error    select frame    @{el}[${index}]
    \    Exit For Loop If    "${msg[0]}" == "PASS"
    RUN KEYWORD IF    "${msg[0]}" == "PASS"    set variable    ${True}
    ...    ELSE IF    "${msg[0]}" == "FAIL"    select frame    @{el}[${index}]

返回frame
    [Documentation]    返回主frame
    Unselect Frame

切换窗口
    [Arguments]    ${locator}
    [Documentation]    跳转到新窗口
    ...    ${locator}是定位策略：
    ...    1、使用new关键字跳转到最新的页面：New
    ...    2、使用main关键字跳转到主页面：main
    ...    3、使用标题title切换：title=百度
    ...    4、使用网址url切换：url=https://www.baidu.com/
    select window    ${locator}

关闭窗口
    close window

截图
    [Arguments]    ${addr}=default
    ${time}    evaluate    time.strftime('%Y.%m.%d.%H.%M.%S')    time
    ${addr_first}    evaluate    [str(pathlib2.Path('${CURDIR}').parent/'screenshot') if '${addr}' == 'default' else str(pathlib2.Path('${CURDIR}').parent/'screenshot/${addr}')]    pathlib2
    Selenium2Library.Capture Page Screenshot    ${addr_first[0]}/${time}.png

回车
    [Arguments]    ${locator}    ${index}=0
    @{el}    判断元素个数并包含    ${locator}    ${index}
    : FOR    ${i}    IN RANGE    50
    \    ${msg}    Run Keyword And Ignore Error    press key    @{el}[${index}]    \\13
    \    Exit For Loop If    "${msg[0]}" == "PASS"
    RUN KEYWORD IF    "${msg[0]}" == "PASS"    set variable    ${True}
    ...    ELSE IF    "${msg[0]}" == "FAIL"    press key    @{el}[${index}]    \\13

弹框确定
    #点击弹框中的确定
    ${msg}    Handle Alert    timeout=30 s
    [Return]    ${msg}

弹框取消
    #点击弹框中的取消
    ${msg}    Handle Alert    action=DISMISS    timeout=30 s
    [Return]    ${msg}

包含检查点
    [Arguments]    ${actual}    ${expect}
    [Documentation]    ${actual}是实际结果；
    ...    ${expect}是预期结果；
    log    ${actual.replace('\n',',')}    #打印实际结果
    log    ${expect}    #打印预期结果
    Should Not Be Empty    ${actual}    get value is empty
    should contain    ${expect}    ${actual.replace('\n',',')}    msg=错误，预期结果和实际 结果不相同

得到长度
    [Arguments]    ${x}
    [Documentation]    得到字符串的长度，并返回；
    ...    参数使用${}的方式；
    ${y}    Get Length    ${x}
    [Return]    ${y}

得到属性
    [Arguments]    ${locator}    ${name}    ${index}=0
    [Documentation]    参数${locator}：是定位 方式，例如：id=kw；
    ...    参数${name}：是要得到的属性名称；
    ...    ${index}是元素索引：当定位是一组元素时候使用；
    @{el}    判断元素个数并包含    ${locator}    ${index}
    Set Focus To Element    @{el}[${index}]
    ${atrr}    Selenium2Library.Get Element Attribute    @{el}[${index}]    ${name}
    [Return]    ${atrr}

连接字符串
    [Arguments]    ${str1}    ${str2}
    [Documentation]    连接字符串，输入连个参数，返回一串字符
    ${text}    Catenate    SEPARATOR=    ${str1}    ${str2}
    [Return]    ${text}

rf输入时间
    [Arguments]    ${locator}    ${number}
    [Documentation]    \#给input标签输入日期 参数${locator} 是：定位方式 参数${number}：是给当前时间 加或减少的天数    #增加3天：输入数字3即可    减少3天：输入-3即可
    ${t1}    get current date
    ${t2}    add time to date    ${t1}    ${number}days
    wait until page contains element    ${locator}    30    page not contains element
    Set Focus To Element    ${locator}
    assign id to element    ${locator}    ${t1}
    execute javascript    window.document.getElementById('${t1}').value='${t2[0:10]}'
    #给input标签输入日期    参数${locator} 是：定位方式    参数${number}：是给当前时间 加或减少的天数
    #增加3天：输入数字3即可    减少3天：输入-3即可

py输入时间
    [Arguments]    ${locator}    ${y}    ${z}    ${d}
    ${t1}    evaluate    int(${d})
    ${t2}    Date Weekend    ${y}    ${z}    ${t1}
    wait until page contains element    ${locator}    30    page not contains element
    ${t3}    get current date
    assign id to element    ${locator}    ${t3}
    execute javascript    window.document.getElementById('${t3}').value='${t2}'
    #给input标签输入日期    参数${x}是定位方式    参数${y}是：是否判断周末 判断输入yes，不判断输入no    ${d}:增减的天数
    #${z},增加日期输入+ 减少日期输入-    参数${d}是要减少或增加的天数

py输入礼拜四
    [Arguments]    ${locator}
    ${t1}    Date Thursdy
    wait until page contains element    ${locator}    30    page not contains element
    ${t2}    get current date
    assign id to element    ${locator}    ${t2}
    execute javascript    window.document.getElementById('${t2}').value='${t1}'
    #参数${locator}是输入框的 定位方式

读取excel数据
    [Arguments]    ${excel_name}    ${index}=0
    [Documentation]    读取excel的数据，参数${excel_name} 为：excel的名称；
    ...    参数 ${index}=0：excel工作表索引，默认是第一个工作表；
    ...    读取出来的数据默认是一个二维列表
    ${addr}    Evaluate    str(pathlib2.Path('${CURDIR}').parent/'data/${excel_name}.xlsx')    pathlib2
    @{z}    Read Excel Data    ${addr}
    Set Global Variable    ${data}    ${z[${index}]}
    [Return]    @{z[${index}]}

解压文件
    [Arguments]    ${x}    ${y}
    evaluate    os.system("WinRAR x ${x} ${y}")    os

得到当前网址
    ${url}    Get Location
    [Return]    ${url}

新会话
    [Arguments]    ${host}
    create session    api    ${host}

关闭所有会话
    delete all sessions

入参数据转换
    [Arguments]    ${message}
    [Documentation]    输入入参数据，将数据装换成字典
    ...    输入格式为：page=1,Size=4
    ...    返回一个json数据
    ${params}    Convert Dict    ${message}
    [Return]    ${params}

json转换
    [Arguments]    ${dict}
    [Documentation]    输入一组数据装换成json格式，例子：{'name': False, 'age': 26, 'aa': True, 'bb': None, 'cc': 'jksdfnksnk', 'dd': '狮子座'}
    ${x}    evaluate    ${dict}
    ${json}    evaluate    json.dumps(${x},indent=4,ensure_ascii=False)    json
    [Return]    ${json}

表格得到数据
    [Arguments]    ${locator}    ${row}    ${column}    ${index}=0
    @{el}    判断元素个数并显示    ${locator}    ${index}
    ${name}    evaluate    str(time.time()).replace('.','')    time
    Assign Id To Element    @{el}[${index}]    id_${name}
    wait until page contains element    css:#id_${name} tr:first-child td    30
    Wait Until Element Is Visible    css:#id_${name} tr:first-child td    30
    : FOR    ${i}    IN RANGE    50
    \    ${msg}    Run Keyword And Ignore Error    Get Table Cell    @{el}[${index}]    ${row}    ${column}
    \    Exit For Loop If    "${msg[0]}" == "PASS"
    ${text}    RUN KEYWORD IF    "${msg[0]}" == "PASS"    Get Table Cell    @{el}[${index}]    ${row}    ${column}
    ...    ELSE IF    "${msg[0]}" == "FAIL"    Get Table Cell    @{el}[${index}]    ${row}    ${column}
    BuiltIn.Should Not Be Empty    ${text}
    [Return]    ${text}

表格得到大小和位置
    [Arguments]    ${locator}    ${text}    ${index}=0
    @{el}    判断元素个数并包含    ${locator}    ${index}
    ${name}    evaluate    str(time.time()).replace('.','')    time
    Assign Id To Element    @{el}[${index}]    id_${name}
    wait until page contains element    css:#id_${name} tbody tr:first-child td    30
    ${row}    Execute Javascript    return document.querySelectorAll('#id_${name} tr').length
    ${col}    Execute Javascript    return document.querySelectorAll('#id_${name} tbody tr:first-child td').length
    @{msg}    create list    表格是一个： ${row} 行 ${col} 列的表格
    @{demo_01}    create list    要查找的文字所在位置为：
    BuiltIn.Set Global Variable    ${demo}    ${demo_01}
    : FOR    ${i}    IN RANGE    1    ${row}+1
    \    表格数据    @{el}[${index}]    ${i}    ${col}    ${text}
    Append To List    ${msg}    ${demo}
    log    ${msg}
    [Return]    ${msg}

表格数据
    [Arguments]    ${locator}    ${i}    ${col}    ${text}
    : FOR    ${j}    IN RANGE    1    ${col}+1
    \    ${msg}    Selenium2Library . Get Table Cell    ${locator}    ${i}    ${j}
    \    run keyword if    '''${text}''' in '''${msg}'''    Append To List    ${demo}    [${i},${j}]

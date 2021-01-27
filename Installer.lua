-- ONLY WORKS WITH MASTER BRANCH
ShowLicenceBig = true -- change this to remove the part of license of instalator

FilesToIgnore = {}
FilesToIgnore["README.md"] = true
FilesToIgnore[".gitignore"] = true
FilesToIgnore["LICENSE"] = true
FilesToIgnore["version"] = true

--Suport to special simbols
if (_CC_VERSION ~= nil) then
    string.char = function () return "x" end
end

-- https://github.com/ * Name * /
AUTHOR = "<InsertAuthor>"

-- https://github.com/ AUTHOR / * Repository * 
project = "<InsertRepository>"

Repo = AUTHOR.."/"..project

link = "https://github.com/"..Repo.."/archive/master.zip"

LinkStartFolder = project.."-master/"
LinkEndFolder = "UT" --DONT TOUCH

VersionLink = "https://raw.githubusercontent.com/"..Repo.."/master/version"

FilesBaseURL = "https://raw.githubusercontent.com/"..Repo.."/master/"

SizeUrl = "https://api.github.com/repos/"..Repo

BigLicenseURL = "https://raw.githubusercontent.com/"..Repo.."/master/LICENSE"
Version = 0.0
Size = 0 --in bytes
License = "NONE"

Files = {}
--Drawn MessageBox

ScreenX, ScreenY = term.getSize()
paintutils.drawBox(ScreenX/2-ScreenX/4,ScreenY/2-ScreenY/4, ScreenX/2+ScreenX/4, ScreenY/2-ScreenY/4, colors.lime)
paintutils.drawFilledBox(ScreenX/2-ScreenX/4,ScreenY/2-ScreenY/4+1, ScreenX/2+ScreenX/4, ScreenY/2+ScreenY/4, colors.gray)
term.setCursorPos(ScreenX/2-ScreenX/4, ScreenY/2-ScreenY/4)
term.setBackgroundColor(colors.lime)
term.setTextColor(colors.gray)
term.setCursorPos((ScreenX/2-string.len(project.." - Instalador")/2), ScreenY/2-ScreenY/4)
term.write(" "..project.." - Instalador")
--Drawn texts
term.setBackgroundColor(colors.gray)
term.setTextColor(colors.white)
term.setCursorPos(ScreenX/2-string.len("Obtendo informacoes ...")/2, ScreenY/2-ScreenY/4+2)
--[Get the data]--
function GetData()
    local FileRaw = http.get(VersionLink)
    if (FileRaw == nil) then
        Version = "ERRO"
    else
        Version = FileRaw.readAll()
    end
    local SizeRaw = http.get(SizeUrl)
    if (SizeRaw == nil) then
        Size = "ERRO"
    else
        local Data = SizeRaw.readAll()
        for J = 1, string.len(Data) do
            if (string.sub(Data, J, J+6) == '"size":') then
                for P = J+6, string.len(Data) do
                    if (string.sub(Data, P, P) == ",") then
                        Size = tonumber(string.sub(Data, J+7, P-1))*125
                        break
                    end
                end
            end
        end
        if (ShowLicenceBig == false) then
            for U = 1, string.len(Data) do
                if (string.sub(Data, U, U+9) == '"license":') then
                    for H = U+9, string.len(Data) do
                        if (string.sub(Data, H, H+5) == '"key":') then
                            for I = H+5, string.len(Data) do
                                if (string.sub(Data, I, I) == ",") then
                                    License = string.sub(Data, H+7, I-2)
                                    break
                                end
                            end
                        end
                    end
                end
            end
        end
    end
end

function GETBIGLICENSE()

end
--[Show a gif on screen]--
function LoadingGif1()
    while true do
        term.setTextColor(colors.white)
        term.setCursorPos(ScreenX/2-string.len("Obtendo informacoes ...")/2, ScreenY/2-ScreenY/4+2)
        term.write("Obtendo informacoes    ")
        sleep(0.5)
        term.setCursorPos(ScreenX/2-string.len("Obtendo informacoes ...")/2, ScreenY/2-ScreenY/4+2)
        term.write("Obtendo informacoes .  ")
        sleep(0.5)
        term.setCursorPos(ScreenX/2-string.len("Obtendo informacoes ...")/2, ScreenY/2-ScreenY/4+2)
        term.write("Obtendo informacoes .. ")
        sleep(0.5)
        term.setCursorPos(ScreenX/2-string.len("Obtendo informacoes ...")/2, ScreenY/2-ScreenY/4+2)
        term.write("Obtendo informacoes ...")
        sleep(0.5)
    end
end
parallel.waitForAny(GetData, LoadingGif1)
paintutils.drawFilledBox(ScreenX/2-ScreenX/4,ScreenY/2-ScreenY/4+1, ScreenX/2+ScreenX/4, ScreenY/2+ScreenY/4, colors.gray)
term.setCursorPos(ScreenX/2-ScreenX/4+1,ScreenY/2-ScreenY/4+2)
XT, YT = term.getCursorPos()
term.write("Versao: "..Version)
term.setCursorPos(XT, YT+1)
term.write("Tamanho: ")
term.setTextColor(colors.lime)
term.write(Size)
term.setTextColor(colors.white)
term.write(" Bytes")
term.setCursorPos(XT, YT+2)
term.write("Disponivel: ")
term.setTextColor(colors.lime)
term.write(fs.getFreeSpace("/"))
term.setTextColor(colors.white)
term.write(" Bytes")
term.setCursorPos(XT, YT+3)
term.write("Restante: ")
if (fs.getFreeSpace("/")-Size > 100000) then
    term.setTextColor(colors.lime)
elseif (fs.getFreeSpace("/")-Size > 10000) then
    term.setTextColor(colors.yellow)
else
    term.setTextColor(colors.red)
end
term.write(fs.getFreeSpace("/")-Size)
term.setTextColor(colors.white)
term.write(" Bytes")
if (ShowLicenceBig == false) then
    term.setCursorPos(XT, YT+4)
    term.write("Licenca: "..License)
end
sleep(0.5)
term.setCursorPos(XT, YT+5)
if (fs.getFreeSpace("/") < Size) then
    term.setTextColor(colors.red)
    term.write("Espaco Insuficiente")
    term.setTextColor(colors.white)
    term.setCursorPos(XT, YT+6)
    term.write("Clique para sair")
    sleep(1)
    os.pullEvent()
    term.setTextColor(colors.white)
    term.setBackgroundColor(colors.black)
    term.setCursorPos(1,1)
    term.clear()
    error()
end
term.write("Deseja instalar o")
term.setCursorPos(XT, YT+6)
term.write(project.."?")
term.setCursorPos((ScreenX/2+ScreenX/4)-3, (ScreenY/2+ScreenY/4)-1)
term.setTextColor(colors.black)
term.setBackgroundColor(colors.lime)
term.write("Sim")
--Listen To User Inputs
function part2()
    paintutils.drawFilledBox(ScreenX/2-ScreenX/4,ScreenY/2-ScreenY/4+1, ScreenX/2+ScreenX/4, ScreenY/2+ScreenY/4, colors.gray)
    LicenseDataTitle = ""
    Line1 = ""
    Line2 = ""
    Line3 = ""
    local function GETDATA()
        BigLicenseRaw = http.get(BigLicenseURL)
        if (BigLicenseRaw == nil) then
            LicenseDataTitle = "ERRO"
        else
            LicenseDataTitle = BigLicenseRaw.readLine()
            Line1 = BigLicenseRaw.readLine()
            Line3 = BigLicenseRaw.readLine()
            BigLicenseRaw.readLine()
            Line2 = BigLicenseRaw.readLine()
        end
    end
    parallel.waitForAny(GETDATA, LoadingGif1)
    paintutils.drawFilledBox(ScreenX/2-ScreenX/4,ScreenY/2-ScreenY/4+1, ScreenX/2+ScreenX/4, ScreenY/2+ScreenY/4+2, colors.gray)
    term.setCursorPos(math.floor(ScreenX/2)-math.floor(string.len(LicenseDataTitle)/2), (ScreenY/2-ScreenY/4)+2)
    L1B, L1T = term.getSize()
    term.setTextColor(colors.white)
    term.write(LicenseDataTitle)
    FinalLine = 1
    function DrawnLine(Line1, InitialY)
        pos = 1
        pox = 1
        if (string.len(Line1) > (ScreenX/2+ScreenX/4)-2) then
            for A = 1, string.len(Line1) do
                if ((ScreenX/2-ScreenX/4)+pox > (ScreenX/2+ScreenX/4)) then
                    pos = pos + 1
                    pox = 2
                else
                    pox = pox + 1
                end
                term.setCursorPos((ScreenX/2-ScreenX/4)-1+pox, InitialY-1+pos)
                term.write(string.sub(Line1, A, A))
            end
            FinalLine = InitialY+pos
        else
            term.setCursorPos(math.floor(ScreenX/2)-math.floor(string.len(Line1)/2), InitialY)
            term.write(Line1)
            FinalLine = InitialY + 1
        end
    end
    DrawnLine(Line1, (ScreenY/2-ScreenY/4)+2+FinalLine)
    DrawnLine(Line2, FinalLine)
    DrawnLine(Line3, FinalLine+1)
    term.setBackgroundColor(colors.lime)
    term.setTextColor(colors.black)
    term.setCursorPos(ScreenX/2+ScreenX/4-8 , ScreenY/2+ScreenY/4+1)
    term.write("Install")
    while true do
        paintutils.drawBox(ScreenX/2-ScreenX/4,ScreenY/2-ScreenY/4, ScreenX/2+ScreenX/4, ScreenY/2-ScreenY/4, colors.lime)
        term.setCursorPos(ScreenX/2-ScreenX/4, ScreenY/2-ScreenY/4)
        term.setBackgroundColor(colors.lime)
        term.setTextColor(16384)
        term.write(string.char(7))
        term.setTextColor(colors.gray)
        term.setCursorPos((ScreenX/2-string.len(project.." - Instalador")/2), ScreenY/2-ScreenY/4)
        term.write(" "..project.." - Instalador")
        --Drawn texts
        term.setBackgroundColor(colors.gray)
        term.setTextColor(colors.white)
        Event, Button, X, Y = os.pullEvent("mouse_click")
        if (X >= math.floor((ScreenX/2+ScreenX/4)-7.8) and X <= math.floor((ScreenX/2+ScreenX/4)-1.8) and Y == math.floor((ScreenY/2+ScreenY/4)+1)) then
                paintutils.drawBox(ScreenX/2-ScreenX/4,ScreenY/2-ScreenY/4, ScreenX/2+ScreenX/4, ScreenY/2-ScreenY/4, colors.lime)
                term.setCursorPos(ScreenX/2-ScreenX/4, ScreenY/2-ScreenY/4)
                term.setBackgroundColor(colors.lime)
                term.setTextColor(colors.gray)
                term.setCursorPos((ScreenX/2-string.len(project.." - Instalador")/2), ScreenY/2-ScreenY/4)
                term.write(" "..project.." - Instalador")
                --Drawn texts
                term.setBackgroundColor(colors.gray)
                term.setTextColor(colors.white)
                part3()
                break
        elseif (X == math.floor((ScreenX/2-ScreenX/4)) and Y == math.floor(ScreenY/2-ScreenY/4)) then
            term.setTextColor(colors.white)
            term.setBackgroundColor(colors.black)
            term.setCursorPos(1,1)
            term.clear()
            error()
            break
        end
    end
end
function part3()
    --INSTALATION
    paintutils.drawFilledBox(ScreenX/2-ScreenX/4,ScreenY/2-ScreenY/4+1, ScreenX/2+ScreenX/4, ScreenY/2+ScreenY/4+2, colors.gray)
    term.setTextColor(colors.white)
    term.setBackgroundColor(colors.gray)
    term.setCursorPos(ScreenX/2-ScreenX/4+2, ScreenY/2-ScreenY/4+2)
    FolderRaw = nil
    function GetAllData()
        FolderRaw = http.get(link)
    end
    function GetAllData2()
        paintutils.drawBox((ScreenX/2-ScreenX/4)+2, (ScreenY/2+ScreenY/4)-6, (ScreenX/2+ScreenX/4)-2, (ScreenY/2+ScreenY/4)-4, colors.black)
        term.setBackgroundColor(colors.gray)
        if (FolderRaw == nil) then
            paintutils.drawFilledBox(ScreenX/2-ScreenX/4,ScreenY/2-ScreenY/4+1, ScreenX/2+ScreenX/4, ScreenY/2+ScreenY/4+2, colors.gray)
            paintutils.drawBox((ScreenX/2-ScreenX/4)+2, (ScreenY/2+ScreenY/4)-6, (ScreenX/2+ScreenX/4)-2, (ScreenY/2+ScreenY/4)-4, colors.black)
            term.setBackgroundColor(colors.gray)
            term.setCursorPos(ScreenX/2-ScreenX/4+2, ScreenY/2-ScreenY/4+2)
            term.setTextColor(colors.red)
            term.write("ERRO: Arquivo nao ")
            term.setCursorPos(ScreenX/2-ScreenX/4+2, ScreenY/2-ScreenY/4+3)
            term.write("encontrado")
            return
        else
            paintutils.drawFilledBox(ScreenX/2-ScreenX/4,ScreenY/2-ScreenY/4+1, ScreenX/2+ScreenX/4, ScreenY/2+ScreenY/8, colors.gray)
            paintutils.drawBox((ScreenX/2-ScreenX/4)+2, (ScreenY/2+ScreenY/4)-6, (ScreenX/2+ScreenX/4)-2, (ScreenY/2+ScreenY/4)-4, colors.black)
            term.setBackgroundColor(colors.gray)
            term.setCursorPos(ScreenX/2-string.len("Extraindo diretorios")/2, ScreenY/2-ScreenY/4+2)
            term.setTextColor(colors.white)
            term.write("Extraindo diretorios")
            ZIPDATA = FolderRaw.readAll()
            for P = 1, string.len(ZIPDATA) do
                if (string.sub(ZIPDATA, P, P+string.len(LinkStartFolder)-1) == LinkStartFolder) then
                    for Z = P+string.len(LinkStartFolder)-1, string.len(ZIPDATA) do
                        if (string.sub(ZIPDATA, Z, Z+string.len(LinkEndFolder)-1) == LinkEndFolder) then
                            table.insert(Files, string.sub(ZIPDATA, P+string.len(LinkStartFolder), Z-1))
                            break
                        end
                    end
                end
            end
            paintutils.drawFilledBox(ScreenX/2-ScreenX/4,ScreenY/2-ScreenY/4+1, ScreenX/2+ScreenX/4, ScreenY/2+ScreenY/8, colors.gray)
            paintutils.drawBox((ScreenX/2-ScreenX/4)+2, (ScreenY/2+ScreenY/4)-6, (ScreenX/2+ScreenX/4)-2, (ScreenY/2+ScreenY/4)-4, colors.black)
            paintutils.drawBox((ScreenX/2-ScreenX/4)+3, (ScreenY/2+ScreenY/4)-5, (ScreenX/2-ScreenX/4)+4, (ScreenY/2+ScreenY/4)-5, colors.red)
            term.setBackgroundColor(colors.gray)
            term.setCursorPos(ScreenX/2-string.len("Criando Diretorios")/2, ScreenY/2-ScreenY/4+2)
            term.setTextColor(colors.white)
            term.write("Criando Diretorios")
            for O,E in ipairs(Files) do
                if (string.sub(E, string.len(E), string.len(E)) == "/") then
                    fs.makeDir(E)
                end
            end
            paintutils.drawFilledBox(ScreenX/2-ScreenX/4,ScreenY/2-ScreenY/4+1, ScreenX/2+ScreenX/4, ScreenY/2+ScreenY/8, colors.gray)
            paintutils.drawBox((ScreenX/2-ScreenX/4)+2, (ScreenY/2+ScreenY/4)-6, (ScreenX/2+ScreenX/4)-2, (ScreenY/2+ScreenY/4)-4, colors.black)
            paintutils.drawBox((ScreenX/2-ScreenX/4)+3, (ScreenY/2+ScreenY/4)-5, (ScreenX/2-ScreenX/4)+4, (ScreenY/2+ScreenY/4)-5, colors.red)
            term.setBackgroundColor(colors.gray)
            term.setCursorPos(ScreenX/2-string.len("Baixando arquivos")/2, ScreenY/2-ScreenY/4+2)
            term.setTextColor(colors.white)
            term.write("Baixando arquivos")
            for J,C in ipairs(Files) do
                if (string.sub(C, string.len(C), string.len(C)) ~= "/") then
                    NumberOfSlachs = 0
                    for U = 1, string.len(C) do
                        if (string.sub(C, string.len(C)-(U), string.len(C)-(U)) == "/") then
                            --FileName = string.sub(C, string.len(C)-(U-1), string.len(C))
                            --Dir = string.sub(C, 1, string.len(C)-(U))
                            if (FilesToIgnore[string.sub(C, 1, string.len(C)-(U))..string.sub(C, string.len(C)-(U-1), string.len(C))] == nil) then
                                FiRAW = http.get(FilesBaseURL..string.sub(C, 1, string.len(C)-(U))..string.sub(C, string.len(C)-(U-1), string.len(C)))
                                if (FiRAW == nil) then
                                    --ERROR
                                    print("ERRO")
                                else
                                    FileContent = FiRAW.readAll()
                                    FileWriter = fs.open(string.sub(C, 1, string.len(C)-(U))..string.sub(C, string.len(C)-(U-1), string.len(C)), "w") 
                                    FileWriter.write(FileContent)
                                    FileWriter.close()
                                    if ((ScreenX/2-ScreenX/4)+1+J/2 < (ScreenX/2+ScreenX/4)-2) then paintutils.drawBox((ScreenX/2-ScreenX/4)+3, (ScreenY/2+ScreenY/4)-5, (ScreenX/2-ScreenX/4)+1+J/2, (ScreenY/2+ScreenY/4)-5, colors.red) else paintutils.drawBox((ScreenX/2-ScreenX/4)+3, (ScreenY/2+ScreenY/4)-5, (ScreenX/2-ScreenX/4)+1+J/5, (ScreenY/2+ScreenY/4)-5, colors.lime) end
                                    paintutils.drawBox((ScreenX/2-ScreenX/4)+2, (ScreenY/2+ScreenY/4)-6, (ScreenX/2+ScreenX/4)-2, (ScreenY/2+ScreenY/4)-4, colors.black)
                                    paintutils.drawFilledBox((ScreenX/2-ScreenX/4), (ScreenY/2+ScreenY/4)-4, (ScreenX/2-ScreenX/4)+1, (ScreenY/2+ScreenY/4)-6)
                                    term.setBackgroundColor(colors.gray)
                                end
                                break
                            end
                        end
                        NumberOfSlachs = 0
                        if (string.sub(C, string.len(C)-(U), string.len(C)-(U)) == "/") then
                            NumberOfSlachs = NumberOfSlachs + 1
                        end
                    end
                    if (NumberOfSlachs == 0 and C ~= "" and C ~= nil) then
                        if (FilesToIgnore[C] == nil) then
                            FiRAW = http.get(FilesBaseURL..C)
                            if (FiRAW == nil) then
                                --ERROR
                                print("ERRO")
                            else
                                FileContent = FiRAW.readAll()
                                FileWriter = fs.open(C, "w") 
                                FileWriter.write(FileContent)
                                FileWriter.close()
                                if ((ScreenX/2-ScreenX/4)+1+J/2 < (ScreenX/2+ScreenX/4)-2) then paintutils.drawBox((ScreenX/2-ScreenX/4)+3, (ScreenY/2+ScreenY/4)-5, (ScreenX/2-ScreenX/4)+1+J/2, (ScreenY/2+ScreenY/4)-5, colors.red) else paintutils.drawBox((ScreenX/2-ScreenX/4)+3, (ScreenY/2+ScreenY/4)-5, (ScreenX/2-ScreenX/4)+1+J/5, (ScreenY/2+ScreenY/4)-5, colors.lime) end
                                paintutils.drawBox((ScreenX/2-ScreenX/4)+2, (ScreenY/2+ScreenY/4)-6, (ScreenX/2+ScreenX/4)-2, (ScreenY/2+ScreenY/4)-4, colors.black)
                                paintutils.drawFilledBox((ScreenX/2-ScreenX/4), (ScreenY/2+ScreenY/4)-4, (ScreenX/2-ScreenX/4)+1, (ScreenY/2+ScreenY/4)-6)
                                term.setBackgroundColor(colors.gray)
                            end
                        end
                    end
                end
            end
            paintutils.drawBox((ScreenX/2-ScreenX/4)+3, (ScreenY/2+ScreenY/4)-5, (ScreenX/2+ScreenX/4)-3, (ScreenY/2+ScreenY/4)-5, colors.lime)
            term.setBackgroundColor(colors.gray)
        end
    end
    parallel.waitForAny(GetAllData, LoadingGif1)
    GetAllData2()
    term.setCursorPos((ScreenX/2+ScreenX/4)-7, ScreenY/2+ScreenY/4+1)
    term.setTextColor(colors.black)
    term.setBackgroundColor(colors.lime)
    term.write("Proximo")
    while true do
        Event, Button, X, Y = os.pullEvent("mouse_click")
        if (X >= math.floor((ScreenX/2+ScreenX/4)-6.8) and X <= math.floor((ScreenX/2+ScreenX/4)-0.8) and Y == math.floor((ScreenY/2+ScreenY/4)+1)) then
            paintutils.drawBox(ScreenX/2-ScreenX/4,ScreenY/2-ScreenY/4, ScreenX/2+ScreenX/4, ScreenY/2-ScreenY/4, colors.lime)
            term.setCursorPos(ScreenX/2-ScreenX/4, ScreenY/2-ScreenY/4)
            term.setBackgroundColor(colors.lime)
            term.setTextColor(colors.gray)
            term.setCursorPos((ScreenX/2-string.len(project.." - Instalador")/2), ScreenY/2-ScreenY/4)
            term.write(" "..project.." - Instalador")
            --Drawn texts
            term.setBackgroundColor(colors.gray)
            term.setTextColor(colors.white)
            -------------------------------------
            --Put here the finish code-----------
            --In that case the code will reboot the computer
            -------------------------------------
            os.reboot()
            -------------------------------------
        end
    end
end
sleep(0)
while true do
    paintutils.drawBox(ScreenX/2-ScreenX/4,ScreenY/2-ScreenY/4, ScreenX/2+ScreenX/4, ScreenY/2-ScreenY/4, colors.lime)
    term.setCursorPos(ScreenX/2-ScreenX/4, ScreenY/2-ScreenY/4)
    term.setBackgroundColor(colors.lime)
    term.setTextColor(colors.red)
    term.write(string.char(7))
    term.setTextColor(colors.gray)
    term.setCursorPos((ScreenX/2-string.len(project.." - Instalador")/2), ScreenY/2-ScreenY/4)
    term.write(" "..project.." - Instalador")
    --Drawn texts
    term.setBackgroundColor(colors.gray)
    term.setTextColor(colors.white)
    Event, Button, X, Y = os.pullEvent("mouse_click")
    if (X >= math.floor((ScreenX/2+ScreenX/4)-2.8) and X <= math.floor((ScreenX/2+ScreenX/4)-0.8) and Y == math.floor((ScreenY/2+ScreenY/4)-1)) then
        paintutils.drawBox(ScreenX/2-ScreenX/4,ScreenY/2-ScreenY/4, ScreenX/2+ScreenX/4, ScreenY/2-ScreenY/4, colors.lime)
        term.setCursorPos(ScreenX/2-ScreenX/4, ScreenY/2-ScreenY/4)
        term.setBackgroundColor(colors.lime)
        term.setTextColor(colors.gray)
        term.setCursorPos((ScreenX/2-string.len(project.." - Instalador")/2), ScreenY/2-ScreenY/4)
        term.write(" "..project.." - Instalador")
        --Drawn texts
        term.setBackgroundColor(colors.gray)
        term.setTextColor(colors.white)
        if (ShowLicenceBig == true) then
            part2()
            break
        else
            part3()
            break
        end
    elseif (X == math.floor((ScreenX/2-ScreenX/4)) and Y == math.floor(ScreenY/2-ScreenY/4)) then
        term.setTextColor(colors.white)
        term.setBackgroundColor(colors.black)
        term.setCursorPos(1,1)
        term.clear()
        error()
        break
    end
end

--[Created by: Space_Interprise]--

function DeclaredData()
    --DataWillSaved
        ProgramName = ""
        SignalCable = ""
        ElevatorMonitor = ""
        NumberOfLevels = 0
        TforTerreo = false
        NumberOfSubterrainLevels = 0
        DataSide = ""
        levelsMonitor = {}
        --DataWillNotBeSaved
        DataFile = 'ElevatorCfg.lua'
        --ElevatorStates
        ElevatorIsMoving = false
        MovingTo = 1
        ElevatorStucked = false
        --ProgramsStates

            ComputerScreenX, ComputerScreenY = term.getSize()
end

exit = false

function DrawnScreen()
    term.clear()
    term.setTextColor(colors.orange)
    term.setCursorPos(1,1)
    term.write("-----------------------------------------------------------------------------")
    term.setCursorPos((ComputerScreenX/2)-(string.len(ProgramName)/2), 1)
    term.write(ProgramName)
    term.setTextColor(colors.white)
    term.setCursorPos(1,2)
end

function Setup() 
    ProgramName = "SuperElevator"
    ComputerScreenX, ComputerScreenY = term.getSize() 
    --1--SignalCable
    repeat
        DrawnScreen()
        print("Selecione o lado na qual se encontra o cabo de sinal do elevador:")
        sides = {"Frente", "Trás", "Esquerda", "Direita", "Cima", "Baixo"}
        side = {"front", "back", "left", "right", "top", "bottom"}
        x = 1
        while (x < 7) do
            print("["..x.."] "..sides[x])
            x = x +1
        end
        term.setTextColor(colors.red)
        term.write("> ")
        term.setTextColor(colors.white)
        local VerifySignalCable = io.read()
        VerifySignalCable = tonumber(VerifySignalCable)
        if (VerifySignalCable == nil or VerifySignalCable >6 or VerifySignalCable <1) then
            term.setTextColor(colors.red)
            print("Formato Invalido!")
            term.setTextColor(colors.white)
        else
            SignalCable = side[VerifySignalCable]
            term.setTextColor(colors.yellow)
            print("Lado do cabo de sinal: "..sides[VerifySignalCable])
            term.setTextColor(colors.white)
        end
        sleep(2)
    until SignalCable ~= ""
    --2--ElevatorMonitor
    repeat
        DrawnScreen()
        print("Porfavor clique no monitor posicionado dentro do elevador, aperte ENTER caso não haja um monitor!")
        peripherals = peripheral.getNames()
        y = table.getn(peripherals)
        z = 1
        if (y <= 0) then
            term.setTextColor(colors.red)
            print("ERRO: Não há nenhum periferal conectado a este computador!")
        else 
            while (z < y+1) do
                if (peripheral.getType(peripherals[z]) == "monitor") then
                    --Monitor
                    monitor = peripheral.wrap(peripherals[z])
                    monitor.setBackgroundColor(colors.blue)
                    monitor.clear()
                    monitorx1, monitory1 = monitor.getSize()
                    monitor.setCursorPos((monitorx1/2)-(string.len("Dentro")/2)+1, (monitory1/2)+1)
                    monitor.write("Dentro")
                end
                z = z +1
            end
        end
        EventType, MonitorId, _, _ = os.pullEvent()
        if (EventType == "key" and MonitorId == 28) then
            ElevatorMonitor = "NONE"
            term.setTextColor(colors.red)
            print("Não há nenhum monitor dentro do elevador!")
            term.setTextColor(colors.white)
        elseif (EventType == "monitor_touch") then
            ElevatorMonitor = tostring(MonitorId)
            term.setTextColor(colors.yellow)
            print("Definindo monitor dentro do elevador para: "..MonitorId)
            term.setTextColor(colors.white)
            for a, b in ipairs(peripheral.getNames()) do
                if (peripheral.getType(b) == "monitor") then
                    monitor4 = peripheral.wrap(b)
                    monitor4.setBackgroundColor(colors.black)
                    monitor4.clear()
                end
            end
        end
        sleep(2)
    until ElevatorMonitor ~= ""
    --3--Andares
    repeat
        DrawnScreen()
        print("Por favor digite o numero de andares do elevador: ")
        term.setTextColor(colors.red)
        term.write("> ")
        term.setTextColor(colors.white)
        local NumberOfLeveis = io.read()
        NumberOfLeveis = tonumber(NumberOfLeveis)
        if (NumberOfLeveis < 2) then
            term.setTextColor(colors.red)
            print("O numero de andares deve ser maior que 2!")
            term.setTextColor(colors.white)
        else
            term.setTextColor(colors.yellow)
            print("Numero de andares: ".. NumberOfLeveis)
            term.setTextColor(colors.white)
            NumberOfLevels = NumberOfLeveis
        end
        sleep(2)
    until NumberOfLevels ~= 0
    --4--Use T for Terreo
    local TforTerreoVerification = false
    repeat
        DrawnScreen()
        print("Deseja usar o termo 'T' para terreo? ")
        print("sim || não")
        term.setTextColor(colors.red)
        term.write("> ")
        term.setTextColor(colors.white)
        local TforT = io.read()
        if (TforT == "sim" or TforT == "Sim" or TforT == "SIM") then
            TforTerreoVerification = true
            TforTerreo = true
            term.setTextColor(colors.yellow)
            print("Selecionado: Sim")
            term.setTextColor(colors.white)
        elseif (TforT == "não" or TforT == "Não" or TforT == "nao" or TforT == "Nao" or TforT == "NÃO" or TforT == "NAO") then
            TforTerreoVerification = true
            TforTerreo = false
            term.setTextColor(colors.yellow)
            print("Selecionado: Não")
            term.setTextColor(colors.white)
        else 
            term.setTextColor(colors.red)
            print("Fomato Invalido!")
            term.setTextColor(colors.white)
        end
        sleep(2)
    until TforTerreoVerification == true
    --5--subterrainLevels
    repeat
        DrawnScreen()
        print("Qual a quantidade de andares subterraneos?")
        term.setTextColor(colors.red)
        term.write("> ")
        term.setTextColor(colors.white)
        local TValue = tonumber(io.read())
        if (TValue == nil) then
            term.setTextColor(colors.red)
            print("Digite 0 ou numero menor caso não haja nenhum andar subterraneo!")
            term.setTextColor(colors.white)
        elseif (TValue > NumberOfLevels-1) then
            term.setTextColor(colors.red)
            print("O numero de andares subterraneos deve ser menor que o numero de andares!")
            term.setTextColor(colors.white)
        elseif (TValue >0) then
            term.setTextColor(colors.yellow)
            print("Numero de andares subterraneos: "..TValue)
            term.setTextColor(colors.white)
            NumberOfSubterrainLevels = value
        elseif (TValue <= 0) then
            term.setTextColor(colors.red)
            print("Nenhum andar subterraneo!")
            term.setTextColor(colors.white)
            NumberOfSubterrainLevels = -1
        end
        sleep(2)
    until NumberOfSubterrainLevels ~= 0
    --6--receptorSide
    repeat
        DrawnScreen()
        print("Selecione o lado na qual se encontra o cabo detector do elevador:")
        sides = {"Frente", "Trás", "Esquerda", "Direita", "Cima", "Baixo"}
        side = {"front", "back", "left", "right", "top", "bottom"}
        x = 1
        while (x < 7) do
            print("["..x.."] "..sides[x])
            x = x +1
        end
        term.setTextColor(colors.red)
        term.write("> ")
        term.setTextColor(colors.white)
        local VerifyDataCable = io.read()
        VerifyDataCable = tonumber(VerifyDataCable)
        if (VerifyDataCable == nil or VerifyDataCable >6 or VerifyDataCable <1 or side[VerifyDataCable] == SignalCable) then
            term.setTextColor(colors.red)
            print("Lado Invalido!")
            term.setTextColor(colors.white)
        else
            DataSide = side[VerifyDataCable]
            term.setTextColor(colors.yellow)
            print("Lado do cabo detector: "..sides[VerifyDataCable])
            term.setTextColor(colors.white)
        end
        sleep(2)
    until DataSide ~= ""
    --7--identify
    repeat
        DrawnScreen()
        print("Clique nos monitores na ordem em que aparecem seus respectivos andares!")
        local Current = 1
        while (Current < NumberOfLevels+1) do
            peripherals = peripheral.getNames()
            y = table.getn(peripherals)
            z = 1
            if (y <= 0) then
                term.setTextColor(colors.red)
                print("ERRO: Não há nenhum periferal conectado a este computador!")
                Current = NumberOfLevels+10
            else 
                --Image on monitors
                p = 1
                ClickedMonitors = {"ignore"}
                while (p < y+1) do
                    local monitors = peripherals
                    if (monitors[p] ~= nil and peripheral.getType(monitors[p]) == "monitor") then 
                        monitor2 = peripheral.wrap(monitors[p])
                        monitor2X, monitor2Y = monitor2.getSize()
                        if (monitors[p] == ElevatorMonitor or levelsMonitor[p-1] == monitors[p]) then
                            monitor2.setBackgroundColor(colors.black)
                            monitor2.clear()
                        else 
                            monitor2.setBackgroundColor(colors.blue)
                            monitor2.clear()
                            if (NumberOfSubterrainLevels ~= -1) then
                                monitor2.setCursorPos(((monitor2X/2)-(string.len(tostring(Current-NumberOfSubterrainLevels))/2))+1, (monitor2Y/2)+1)
                                monitor2.write(tostring(Current-NumberOfSubterrainLevels))
                            else
                                monitor2.setCursorPos(((monitor2X/2)-(string.len(tostring(Current))/2))+1, (monitor2Y/2)+1)
                                monitor2.write(tostring(Current))
                            end    
                        end
                    end
                    p = p + 1
                end
            end
            EventType, MonitorId, _, _ = os.pullEvent()
            if (EventType == "monitor_touch") then
                if (MonitorId ~= ElevatorMonitor) then
                    term.setTextColor(colors.yellow)
                    if (NumberOfSubterrainLevels ~= -1) then
                        print("Definindo monitor do andar "..Current-NumberOfSubterrainLevels.." para: "..MonitorId)
                        term.setTextColor(colors.white)
                    else
                        print("Definindo monitor do andar "..Current.." para: "..MonitorId)
                        term.setTextColor(colors.white)
                    end
                    ClickedMonitors[Current] =  MonitorId
                    levelsMonitor[Current] = MonitorId
                    monitor3 = peripheral.wrap(MonitorId)
                    monitor3.setBackgroundColor(colors.black)
                    monitor3.clear()
                    Current = Current + 1
                end
            end
        end
        sleep(2)
    until levelsMonitor ~= {}
    --8--Save the data
    DF = fs.open(DataFile, "w")
    DF.write("ProgramName = "..'"'..ProgramName..'"'.."\n".."SignalCable = "..'"'..SignalCable..'"'.."\n".."ElevatorMonitor = "..'"'..ElevatorMonitor..'"'.."\n".."NumberOfLevels = "..NumberOfLevels.."\n".."TforTerreo = "..tostring(TforTerreo).."\n".."NumberOfSubterrainLevels = "..NumberOfSubterrainLevels.."\n".."DataSide = "..'"'..DataSide..'"'.."\n".."levelsMonitor = "..textutils.serialise(levelsMonitor))
    DF.close()
end

function VerifyElevatorLevel()
    ColorInput = rs.getBundledInput(DataSide)
    if (ColorInput >3) then
        Level = (ColorInput/4)+2
    else
        Level = ColorInput
    end
    return Level
end

function LOADTHINGS(DF)
    SignalCable = DF.SignalCable
    ElevatorMonitor = DF.ElevatorMonitor
    NumberOfLevels = DF.NumberOfLevels
    TforTerreo = DF.TforTerreo
    NumberOfSubterrainLevels = DF.NumberOfSubterrainLevels
    DataSide = DF.DataSide
    levelsMonitor = DF.levelsMonitor
end

function DrawnButton(CustomMonitor, Color, Monitor5X, Monitor5Y, index)
    if (index < 10) then
        --Drawn button start
        CustomMonitor.setCursorPos((Monitor5X/2)-((string.len("-"..index.."º")/2)), (Monitor5X/2)-1)
        CustomMonitor.setTextColor(Color)
        CustomMonitor.setBackgroundColor(Color)
        CustomMonitor.write(index.."º")
        CustomMonitor.write("-"..index.."º")
        CustomMonitor.setCursorPos((Monitor5X/2)-((string.len("-"..index.."º")/2)), (Monitor5X/2))
        CustomMonitor.write(index.."º")
        CustomMonitor.write("-"..index.."º")
        CustomMonitor.setCursorPos((Monitor5X/2)-((string.len("-"..index.."º")/2)), (Monitor5X/2)+1)
        CustomMonitor.write(index.."º")
        CustomMonitor.write("-"..index.."º")
        --DrawnText
        CustomMonitor.setTextColor(colors.gray)
        if (NumberOfSubterrainLevels ~= -1) then
            if (index-NumberOfSubterrainLevels == 0 and TforTerreo == true) then
                CustomMonitor.setCursorPos((Monitor5X/2)-(string.len("-T-")/2)+1, (Monitor5X/2))
                CustomMonitor.write("-T-")
            else
                if (index-NumberOfSubterrainLevels == 0) then
                    CustomMonitor.setCursorPos((Monitor5X/2)-(string.len(index.."º")/2)+1, (Monitor5X/2))
                    CustomMonitor.write("+"..index-NumberOfSubterrainLevels.."º")
                elseif (index-NumberOfSubterrainLevels < 0) then
                    CustomMonitor.setCursorPos((Monitor5X/2)-(string.len(index.."º")/2)+1, (Monitor5X/2))
                    CustomMonitor.write("-"..index-NumberOfSubterrainLevels.."º")
                elseif (index-NumberOfSubterrainLevels == 0) then
                    CustomMonitor.setCursorPos((Monitor5X/2)-(string.len(index.."º")/2)+1, (Monitor5X/2))
                    CustomMonitor.write("="..index-NumberOfSubterrainLevels.."=")
                else
                    CustomMonitor.setCursorPos((Monitor5X/2)-(string.len(index.."º")/2)+1, (Monitor5X/2))
                    CustomMonitor.write("+"..index.."º")
                end
            end
        else
            if (index == 0 and TforTerreo == true) then
                CustomMonitor.setCursorPos((Monitor5X/2)-(string.len(index.."º")/2)+1, (Monitor5X/2))
                CustomMonitor.write("-T-")
            else
                CustomMonitor.setCursorPos((Monitor5X/2)-(string.len(index.."º")/2)+1, (Monitor5X/2))
                CustomMonitor.write("+"..index.."º")
            end
        end
        --Drawn button end
    elseif ((NumberOfSubterrainLevels ~= -1 and index-NumberOfSubterrainLevels == 0 and red == false) == false and (NumberOfSubterrainLevels == -1 and index == 0 and red == false) == false) then
        --Drawn button start
        CustomMonitor.setCursorPos((Monitor5X/2)-((string.len(index.."º")/2)), (Monitor5X/2)-1)
        CustomMonitor.setTextColor(Color)
        CustomMonitor.setBackgroundColor(Color)
        CustomMonitor.write(index.."º")
        CustomMonitor.write(index.."º")
        CustomMonitor.setCursorPos((Monitor5X/2)-((string.len(index.."º")/2)), (Monitor5X/2))
        CustomMonitor.write(index.."º")
        CustomMonitor.write(index.."º")
        CustomMonitor.setCursorPos((Monitor5X/2)-((string.len(index.."º")/2)), (Monitor5X/2)+1)
        CustomMonitor.write(index.."º")
        CustomMonitor.write(index.."º")
        --DrawnText
        monitor5.setTextColor(colors.gray)
        if (NumberOfSubterrainLevels ~= -1) then
            if (index-NumberOfSubterrainLevels == 0 and TforTerreo == true) then
                CustomMonitor.setCursorPos((Monitor5X/2)-(string.len("-T-")/2)+1, (Monitor5X/2))
                CustomMonitor.write("-T-")
            else
                if (index-NumberOfSubterrainLevels == 0) then
                    CustomMonitor.setCursorPos((Monitor5X/2)-(string.len(index.."º")/2)+1, (Monitor5X/2))
                    CustomMonitor.write("+"..index-NumberOfSubterrainLevels.."º")
                elseif (index-NumberOfSubterrainLevels < 0) then
                    CustomMonitor.setCursorPos((Monitor5X/2)-(string.len(index.."º")/2)+1, (Monitor5X/2))
                    CustomMonitor.write("-"..index-NumberOfSubterrainLevels.."º")
                elseif (index-NumberOfSubterrainLevels == 0) then
                    CustomMonitor.setCursorPos((Monitor5X/2)-(string.len(index.."º")/2)+1, (Monitor5X/2))
                    CustomMonitor.write("="..index-NumberOfSubterrainLevels.."=")
                else
                    CustomMonitor.setCursorPos((Monitor5X/2)-(string.len(index.."º")/2)+1, (Monitor5X/2))
                    CustomMonitor.write("+"..index.."º")
                end
            end
        else
            if (index == 0 and TforTerreo == true) then
                CustomMonitor.setCursorPos((Monitor5X/2)-(string.len(index.."º")/2)+1, (Monitor5X/2))
                CustomMonitor.write("-T-")
            else
                CustomMonitor.setCursorPos((Monitor5X/2)-(string.len(index.."º")/2)+1, (Monitor5X/2))
                CustomMonitor.write("+"..index.."º")
            end
        end
    end
end

function updateElevatorScreen()
    if (ElevatorMonitor ~= "NONE") then
        MonitorElevator = peripheral.wrap(ElevatorMonitor)
        MonitorElevator.setBackgroundColor(colors.lightGray)
        MonitorElevator.clear()
        MEX, MEY = MonitorElevator.getSize()
        MonitorElevator.setBackgroundColor(colors.gray)
        MonitorElevator.setTextColor(colors.gray)
        for MEA=1,MEX do
            MonitorElevator.setCursorPos(MEA,(MEY/3)+1)
            MonitorElevator.write("A")
            for MEB=1,MEY/3 do
                MonitorElevator.setCursorPos(MEA,(MEY-MEB*2)+1)
                MonitorElevator.write("A")
                MonitorElevator.setCursorPos(MEA,(MEY-MEB*2)+2)
                MonitorElevator.write("A")
            end
        end
        --Text
        MonitorElevator.setBackgroundColor(colors.blue)
        MonitorElevator.setTextColor(colors.lightGray)
        ElevatorScreenMessage = "Selecione um"
        ElevatorScreenMessage2 = "andar :D"
        MonitorElevator.setCursorPos(1,(((MEY/3)/2)-1))
        MonitorElevator.write("---------------------------------------------------------")
        MonitorElevator.setTextColor(colors.blue)
        MonitorElevator.setCursorPos(1,(((MEY/3)/2)-1)+1)
        MonitorElevator.write("---------------------------------------------------------")
        MonitorElevator.setCursorPos(1,(((MEY/3)/2)+1))
        MonitorElevator.write("---------------------------------------------------------")
        MonitorElevator.setTextColor(colors.lightGray)
        MonitorElevator.setCursorPos(1,(((MEY/3)/2)+1)+1)
        MonitorElevator.write("---------------------------------------------------------")
        MonitorElevator.setCursorPos((MEX/2)-(string.len(ElevatorScreenMessage)/2)+1,((MEY/3)/2))
        MonitorElevator.write(ElevatorScreenMessage)
        MonitorElevator.setCursorPos((MEX/2)-(string.len(ElevatorScreenMessage2)/2)+1,((MEY/3)/2)+1)
        MonitorElevator.write(ElevatorScreenMessage2)
        --Drawn LevelButtons
        MaxButtonsNumber = 16
        MaxColuns = 4
        MaxLines = 4
        MinYValue = (MEY/3)+2
        MinXValue = 1
        MaxYValue = MEY - ((MEY/3)/2)
        MaxXValue = MEX
        ButtonsX = {}
        ButtonsY = {}
        ButtonXScale = 3

        NumberOfColluns = 1
        NumberOfLines = 1
        --Define the name will be apper in the buttons
        LevelsNames = {}
        for C=0, NumberOfLevels do
            if ( C < 10 ) then
                if ( NumberOfSubterrainLevels == -1 ) then
                    if ( C == 0 and TforTerreo == true ) then
                        table.insert(LevelsNames, "-T-")
                    else
                        table.insert(LevelsNames, "+"..tostring(C).."º")
                    end
                else
                    if (C - NumberOfSubterrainLevels < 0) then
                        table.insert(LevelsNames, "-"..tostring(C - NumberOfSubterrainLevels).."º")
                    elseif (C - NumberOfSubterrainLevels == 0) then
                        if(TforTerreo == true) then
                            table.insert(LevelsNames, "-T-")
                        else
                            table.insert(LevelsNames, "+1º")
                        end
                    else
                        table.insert(LevelsNames, "+"..tostring(C - NumberOfSubterrainLevels).."º")
                    end
                end
            else
                if (NumberOfSubterrainLevels == -1) then
                    if (C == 0 and TforTerreo == true) then
                        table.insert(LevelsNames, "-T-")
                    else
                        table.insert(LevelsNames, tostring(C).."º")
                    end
                else
                    if (C - NumberOfSubterrainLevels < 0) then
                        if (C - NumberOfSubterrainLevels > -9) then
                            table.insert(LevelsNames, "-"..tostring(C - NumberOfSubterrainLevels).."º")
                        else
                            table.insert(LevelsNames, "-"..tostring(C - NumberOfSubterrainLevels))
                        end
                    elseif (C - NumberOfSubterrainLevels == 0) then
                        if(TforTerreo == true) then
                            table.insert(LevelsNames, "-T-")
                        else
                            table.insert(LevelsNames, "+1º")
                        end
                    else
                        if (C - NumberOfSubterrainLevels > 9) then
                            table.insert(LevelsNames, tostring(C - NumberOfSubterrainLevels).."º")
                        else
                            table.insert(LevelsNames, "+"..tostring(C - NumberOfSubterrainLevels).."º")
                        end
                    end
                end
            end
        end
        --YCollums
        for G=0, NumberOfLevels do
            if (LevelsNames[G] ~= nil) then
                NumberOfLines = NumberOfLines + 1
            end
            if (NumberOfLines > 4) then
                NumberOfLines = 1
                NumberOfColluns = NumberOfColluns + 1
            end
        end
        NumberOfLines = NumberOfLines - 1
        MeeyPar = 1
        for H=1, NumberOfLevels do
            for L=1, NumberOfColluns do
                if (math.floor(H/2) ~= math.floor((H/2)+0.9)) then
                    --Primo
                    if (H ~= 1) then
                        local MeeX, meeY = MonitorElevator.getCursorPos()
                        if (NumberOfLines == 4 and NumberOfColluns > 1) then
                            if (meeY ~= MeeyPar and L ~= 1) then
                                MeeX = MeeX - 5 
                            end
                            MeeyPar = meeY
                        end
                        MonitorElevator.setCursorPos(MeeX + 2, math.floor((MinYValue-(L-1))+(L-1)*3))
                    else
                        if (NumberOfLines == 4) then
                            MonitorElevator.setCursorPos(MinXValue, math.floor((MinYValue-(L-1))+(L-1)*3))
                        else
                            MonitorElevator.setCursorPos(math.floor(MaxXValue/2)-((NumberOfLines*3)/2), math.floor((MinYValue-(L-1))+(L-1)*3))
                        end
                    end
                else
                    --par
                    if (H ~= 0) then
                        local MeeX, meeY = MonitorElevator.getCursorPos()
                        if (meeY ~= MeeyPar and L ~= 1) then
                        MeeX = MeeX - 5 
                        end
                        MeeyPar = meeY
                        MonitorElevator.setCursorPos(MeeX + 2, math.floor((MinYValue-(L-1))+(L-1)*3))
                    else
                        MonitorElevator.setCursorPos(math.floor(MaxXValue/2)-((NumberOfLines*3)/2)+5, math.floor((MinYValue-(L-1))+(L-1)*3))
                    end
                end
                if (LevelsNames[H+((L-1)*4)] ~= nil and MovingTo == H and ElevatorIsMoving == false) then
                    MonitorElevator.setBackgroundColor(colors.red)
                elseif (LevelsNames[H+((L-1)*4)] ~= nil and MovingTo == H and ElevatorIsMoving == true) then
                    MonitorElevator.setBackgroundColor(colors.green)
                else
                    MonitorElevator.setBackgroundColor(colors.blue)
                end
                MonitorElevator.setTextColor(colors.lightGray)
                if (LevelsNames[H+((L-1)*4)]) == nil then
                    MonitorElevator.setBackgroundColor(colors.black)
                    MonitorElevator.write("---")
                else
                    local ButtonX, ButtonY = MonitorElevator.getCursorPos()
                    table.insert(ButtonsX, ButtonX)
                    table.insert(ButtonsY, ButtonY)
                    MonitorElevator.write(LevelsNames[H+((L-1)*4)])
                end
            end
        end
    end
end

function ElevatorStart()
    if (ElevatorIsMoving == true) then
        local know = false
        function MoveDown()
            rs.setBundledOutput(SignalCable, colors.orange)
            sleep(0.5)
            rs.setBundledOutput(SignalCable, 0)
        end

        function MoveUp()
            rs.setBundledOutput(SignalCable, colors.white)
            sleep(0.5)
            rs.setBundledOutput(SignalCable, 0)
        end

        --If elevator dont know were he is we will start get down until he know were he is
        if (VerifyElevatorLevel() == 1 and know == false) then
            repeat
                --Elevator dont know were he is
                while (VerifyElevatorLevel() == 0) do
                    MoveDown()
                    sleep(0.5)
                end
            until VerifyElevatorLevel() ~= 0
            sleep(3)
            if (VerifyElevatorLevel() == 0) then
                repeat
                    --Elevator dont know were he is
                    while (VerifyElevatorLevel() == 0) do
                        MoveUp()
                        sleep(3)
                    end
                until VerifyElevatorLevel() ~= 0
            end
        end

        --if elevator know were he is this code above will detect if he need get up or get down
        if (VerifyElevatorLevel() ~= 0) then
            know = true
            if (VerifyElevatorLevel() > MovingTo) then
                --elevator get down
                repeat
                    MoveDown()
                    sleep(0.5)
                until VerifyElevatorLevel() == MovingTo
                sleep(3)
                if (VerifyElevatorLevel() ~= MovingTo) then
                    repeat
                        MoveUp()
                        sleep(3)
                    until VerifyElevatorLevel() == MovingTo
                end
            elseif (VerifyElevatorLevel() < MovingTo) then
                --elevator get up
                repeat
                    MoveUp()
                    sleep(0.5)
                until VerifyElevatorLevel() == MovingTo
                sleep(3)
                if (VerifyElevatorLevel() ~= MovingTo) then
                    repeat
                        MoveDown()
                        sleep(3)
                    until VerifyElevatorLevel() == MovingTo
                end
            end
        end
        ElevatorIsMoving = false
    end
end

function Execute()
    os.loadAPI(DataFile)
    DFN = string.sub(DataFile, 0, string.len(DataFile)-4)
    DF = _G[DFN]
    ProgramName = DF.ProgramName
    if (ElevatorStucked == true) then
        if (NumberOfSubterrainLevels == -1) then
            if (VerifyElevatorLevel() == 1) then
                ElevatorStucked = false
                ElevatorIsMoving = false
            end
        else
            if (VerifyElevatorLevel()-NumberOfSubterrainLevels == 1) then
                ElevatorStucked = false
                ElevatorIsMoving = false
            end
        end
    end
    DrawnScreen()
    term.setTextColor(colors.yellow)
    term.write("Carregando Definições...")
    LOADTHINGS(DF)
    term.setCursorPos(1,3)
    term.write("Definições carregadas com sucesso!")
    term.setCursorPos(1,4)
    term.write("Verificando motor...")
    term.setCursorPos(1,5)
    term.write("Posição do elevador: ")
    term.setTextColor(colors.red)
    if ((VerifyElevatorLevel() == 0 and ElevatorIsMoving == false) == true or ElevatorStucked == true) then
        term.write("Preso no meio do caminho!")
        term.setTextColor(colors.yellow)
        term.setCursorPos(1,6)
        term.write("Retornando elevador para o ")
        term.setTextColor(colors.red)
        if (TforTerreo == true) then
            term.write("Terreo")
        else
            term.write("andar 0")
        end
        term.setTextColor(colors.yellow)
        term.setCursorPos(1,7)
        ElevatorIsMoving = true
        MovingTo = 1
        ElevatorStucked = true
    elseif (VerifyElevatorLevel() == 1 and ElevatorIsMoving == true) then
        term.setTextColor(colors.yellow)
        term.write("Indo para o andar: ")
        term.setTextColor(colors.red)
        if (NumberOfSubterrainLevels == -1) then
            if (MovingTo == 1 and TforTerreo == true) then
                term.write("Terreo")
                term.setTextColor(colors.yellow)
                term.setCursorPos(1,6)
            else
                term.write((MovingTo-1).."º")
                term.setTextColor(colors.yellow)
                term.write(" andar")
                term.setCursorPos(1,6)
            end
        else
            if (MovingTo-NumberOfSubterrainLevels == 1 and TforTerreo == true) then
                term.write("Terreo")
                term.setTextColor(colors.yellow)
                term.setCursorPos(1,6)
            else 
                term.write((MovingTo-NumberOfSubterrainLevels-1).."º")
                term.setTextColor(colors.yellow)
                term.write(" andar")
                term.setCursorPos(1,6)
            end
        end
    else
        if (NumberOfSubterrainLevels == -1) then
            if (VerifyElevatorLevel() == 1 and TforTerreo == true) then
                term.write("Terreo")
                term.setTextColor(colors.yellow)
                term.setCursorPos(1,6)
            else
                term.write((VerifyElevatorLevel()-1).."º")
                term.setTextColor(colors.yellow)
                term.write(" andar")
                term.setCursorPos(1,6)
            end
        else
            if (VerifyElevatorLevel()-NumberOfSubterrainLevels == 1 and TforTerreo == true) then
                term.write("Terreo")
                term.setTextColor(colors.yellow)
                term.setCursorPos(1,6)
            else 
                term.write((VerifyElevatorLevel()-NumberOfSubterrainLevels-1).."º")
                term.setTextColor(colors.yellow)
                term.write(" andar")
                term.setCursorPos(1,6)
            end
        end
    end
    term.write("Numero de andares: ")
    term.setTextColor(colors.red)
    term.write(NumberOfLevels)
    term.setTextColor(colors.yellow)
    local x, y = term.getCursorPos()
    term.setCursorPos(1, y+1)
    --KeysUsage
        local NumberOfLinesUsage = 2
        term.setTextColor(colors.lightBlue)
        term.write("Utilize a tecla ")
        term.setTextColor(colors.red)
        term.write("R ")
        term.setTextColor(colors.lightBlue)
        term.write("Para reiniciar o programa ")
        term.setCursorPos(1,y+2)
        term.setTextColor(colors.lightBlue)
        term.write("Utilize a tecla ")
        term.setTextColor(colors.red)
        term.write("Q ")
        term.setTextColor(colors.lightBlue)
        term.write("Para sair o programa ")
    --EndOfKeysUsage
    term.setCursorPos(1,y+1+NumberOfLinesUsage)
    term.setTextColor(colors.white)
    --Generate all screens in monitors
    function DrawnLevelScreen(index, red)
        value = levelsMonitor[index]
        sleep(0)
        monitor5 = peripheral.wrap(value)
        monitor5.setBackgroundColor(colors.gray)
        monitor5.clear()
        Monitor5X, Monitor5Y = monitor5.getSize()
        if (red == true) then
            DrawnButton(monitor5, colors.red ,Monitor5X, Monitor5Y, index-1)
            index = index + 1 
        elseif (red == false and ElevatorIsMoving == true and MovingTo == index) then
            DrawnButton(monitor5, colors.green ,Monitor5X, Monitor5Y, index-1)
            index = index + 1 
        elseif (red == false and ((ElevatorIsMoving == true and MovingTo ~= index) == true) or ElevatorIsMoving == false) then
            DrawnButton(monitor5, colors.blue ,Monitor5X, Monitor5Y, index-1)
            index = index + 1 
        end
        sleep(0)
    end
end

function monitorDrawn()
    local function FMain()
        while true do
            Execute()
            updateElevatorScreen()
            for n=1,NumberOfLevels do
                if (VerifyElevatorLevel() == n and VerifyElevatorLevel() ~= 0) then
                    DrawnLevelScreen(n, true)
                else
                    DrawnLevelScreen(n, false)
                end
            end
            sleep(2)
        end
    end
    while true do
        parallel.waitForAny(FMain, ElevatorStart)
        sleep(0.5)
    end
end

function ClickVerify()
    while true do
        event, id, PositionX, PositionY = os.pullEvent()
        if (event == "key_up"  or event == "key") then
            if (id == keys.q) then
                x1, y1 = term.getCursorPos()
                term.setCursorPos(1, y1)
                term.setTextColor(colors.red)
                term.write("Saindo...                                                    ")
                sleep(0.5)
                term.clear()
                term.setCursorPos(1,1)
                term.setTextColor(colors.yellow)
                term.write(os.version())
                term.setTextColor(colors.white)
                term.setCursorPos(1,2)
                exit = true
                error()
            elseif (id == keys.r) then
                --RebootProgram
                term.setTextColor(colors.red)
                term.write("Reiniciando...")
                term.setTextColor(colors.white)
                sleep(0.5)
                term.clear()
                sleep(0.1)
                main()
            end
        end
        if (event == "monitor_touch") then
            --Call Elevator with levels monitor
            if (ElevatorIsMoving == false and id ~= ElevatorMonitor) then
                for MonitorIndex, MonitorValue in ipairs(levelsMonitor) do
                    if (MonitorValue == id) then
                        ElevatorStucked = false
                        ElevatorIsMoving = true
                        MovingTo = MonitorIndex
                    end
                end
            elseif (id == ElevatorMonitor and ElevatorIsMoving == false) then
                for PXIndex, PX in ipairs(ButtonsX) do
                    for PIYndex, PY in ipairs(ButtonsY) do
                        if (PositionX > PX and PositionX < PX+3) then
                            if (PositionY == PY) then
                                --Click in a button
                                ElevatorStucked = false
                                ElevatorIsMoving = true
                                MovingTo = PXIndex
                            end
                        end
                    end
                end
            end
        end
        sleep(0)
    end
end

function Execute2()
    Execute()
    while (exit == false) do
        parallel.waitForAny(ClickVerify, monitorDrawn)
        sleep(0)
    end
end

function main()
    DeclaredData()
    if (exit == false) then
        if (fs.exists(DataFile) == true) then
            --Run elevator function
            DeclaredData()
            MovingTo = 1
            ElevatorIsMoving = true
            Execute2()
        else
            --Run instalation function
            Setup()
        end
    end
    if (exit == true) then
        error()
    end
end

main()
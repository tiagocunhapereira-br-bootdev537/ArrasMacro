#Requires AutoHotkey v2.0
#SingleInstance Force
SendMode("Input")
SetKeyDelay(-1, -1)
SetWinDelay(-1)
SetControlDelay(-1)
ListLines(False)
ProcessSetPriority("High")

KeyHistory(0)


global isRunning := false
global compiledMacroSequence := [] 
global configFile := "macro_config.txt"
global rawInput := "basic"


if FileExist(configFile) {
    try {
        rawInput := FileRead(configFile)
        if (Trim(rawInput) == "") {
            rawInput := "basic"
        }
    } catch {
        rawInput := "basic"
    }
} else {
    try {
        FileAppend(rawInput, configFile, "UTF-8")
    }
}


global TankTree := Map()
TankTree["basic"] := " |basic"
TankTree["twin"] := "y|basic"
TankTree["sniper"] := "u|basic" 
TankTree["machine gun"] := "i|basic" 
TankTree["flank guard"] := "h|basic" 
TankTree["director"] := "j|basic" 
TankTree["pounder"] := "k|basic" 
TankTree["trapper"] := "[|basic" 
TankTree["desmos"] := "]|basic" 
TankTree["double twin"] := "y|twin" 
TankTree["triple shot"] := "u|twin" 
TankTree["gunner"] := "i|twin" 
TankTree["hexa tank"] := "h|twin" 
TankTree["helix"] := "j|twin" 
TankTree["dual"] := "k|twin" 
TankTree["bulwark"] := "l|twin" 
TankTree["musket"] := ";|twin" 
TankTree["assassin"] := "y|sniper" 
TankTree["hunter"] := "u|sniper" 
TankTree["minigun"] := "i|sniper" 
TankTree["rifle"] := "h|sniper" 
TankTree["marksman"] := "j|sniper" 
TankTree["bushwhacker"] := "k|sniper" 
TankTree["artillery"] := "y|machine gun" 
TankTree["minigun"] := "u|machine gun" 
TankTree["gunner"] := "i|machine gun" 
TankTree["sprayer"] := "h|machine gun" 
TankTree["hexa tank"] := "y|flank guard" 
TankTree["tri-angle"] := "u|flank guard" 
TankTree["auto-3"] := "i|flank guard" 
TankTree["trap guard"] := "h|flank guard" 
TankTree["tri-trapper"] := "j|flank guard" 
TankTree["triple twin"] := "k|flank guard" 
TankTree["quadruplex"] := "l|flank guard" 
TankTree["overseer"] := "y|director" 
TankTree["cruiser"] := "u|director" 
TankTree["underseer"] := "i|director" 
TankTree["spawner"] := "h|director" 
TankTree["manager"] := "j|director" 
TankTree["big cheese"] := "k|director" 
TankTree["destroyer"] := "y|pounder" 
TankTree["builder"] := "u|pounder" 
TankTree["artillery"] := "i|pounder" 
TankTree["launcher"] := "h|pounder" 
TankTree["shotgun"] := "j|pounder" 
TankTree["eagle"] := "k|pounder" 
TankTree["builder"] := "y|trapper" 
TankTree["tri-trapper"] := "u|trapper" 
TankTree["trap guard"] := "i|trapper" 
TankTree["barricade"] := "h|trapper" 
TankTree["overtrapper"] := "j|trapper" 
TankTree["helix"] := "y|desmos" 
TankTree["smasher"] := "h|basic" 
TankTree["triple twin"] := "y|double twin" 
TankTree["hewn double"] := "u|double twin" 
TankTree["auto-double"] := "i|double twin" 
TankTree["bent double"] := "h|double twin" 
TankTree["penta shot"] := "y|triple shot" 
TankTree["spreadshot"] := "u|triple shot" 
TankTree["bent hybrid"] := "i|triple shot" 
TankTree["bent double"] := "h|triple shot" 
TankTree["triplet"] := "j|triple shot" 
TankTree["triplex"] := "k|triple shot" 
TankTree["auto-gunner"] := "y|gunner" 
TankTree["nailgun"] := "u|gunner" 
TankTree["auto-4"] := "i|gunner" 
TankTree["machine gunner"] := "h|gunner" 
TankTree["gunner trapper"] := "j|gunner" 
TankTree["cyclone"] := "k|gunner" 
TankTree["overgunner"] := "l|gunner" 
TankTree["octo tank"] := "y|hexa tank" 
TankTree["cyclone"] := "u|hexa tank" 
TankTree["hexa-trapper"] := "i|hexa tank" 
TankTree["triplex"] := "y|helix" 
TankTree["quadruplex"] := "u|helix" 
TankTree["ranger"] := "y|assassin" 
TankTree["falcon"] := "u|assassin" 
TankTree["stalker"] := "i|assassin" 
TankTree["auto-assassin"] := "h|assassin" 
TankTree["single"] := "j|assassin" 
TankTree["deadeye"] := "k|assassin" 
TankTree["predator"] := "y|hunter" 
TankTree["x-hunter"] := "u|hunter" 
TankTree["poacher"] := "i|hunter" 
TankTree["ordnance"] := "h|hunter" 
TankTree["dual"] := "j|hunter" 
TankTree["nimrod"] := "k|hunter" 
TankTree["streamliner"] := "y|minigun" 
TankTree["nailgun"] := "u|minigun" 
TankTree["crop duster"] := "i|minigun" 
TankTree["barricade"] := "h|minigun" 
TankTree["vulture"] := "j|minigun" 
TankTree["musket"] := "y|rifle" 
TankTree["crossbow"] := "u|rifle" 
TankTree["armsman"] := "i|rifle" 
TankTree["revolver"] := "h|rifle" 
TankTree["deadeye"] := "y|marksman" 
TankTree["nimrod"] := "u|marksman" 
TankTree["revolver"] := "i|marksman" 
TankTree["fork"] := "h|marksman" 
TankTree["mortar"] := "y|artillery" 
TankTree["ordnance"] := "u|artillery" 
TankTree["beekeeper"] := "i|artillery" 
TankTree["field gun"] := "h|artillery" 
TankTree["streamliner"] := "y|minigun" 
TankTree["nailgun"] := "u|minigun" 
TankTree["crop duster"] := "i|minigun" 
TankTree["barricade"] := "h|minigun" 
TankTree["vulture"] := "j|minigun" 
TankTree["auto-gunner"] := "y|gunner" 
TankTree["nailgun"] := "u|gunner" 
TankTree["auto-4"] := "i|gunner" 
TankTree["machine gunner"] := "h|gunner" 
TankTree["gunner trapper"] := "j|gunner" 
TankTree["cyclone"] := "k|gunner" 
TankTree["overgunner"] := "l|gunner" 
TankTree["redistributor"] := "y|sprayer" 
TankTree["phoenix"] := "u|sprayer" 
TankTree["atomizer"] := "i|sprayer" 
TankTree["focal"] := "h|sprayer" 
TankTree["octo tank"] := "y|hexa tank" 
TankTree["cyclone"] := "u|hexa tank" 
TankTree["hexa-trapper"] := "i|hexa tank" 
TankTree["fighter"] := "y|tri-angle" 
TankTree["booster"] := "u|tri-angle" 
TankTree["falcon"] := "i|tri-angle" 
TankTree["bomber"] := "h|tri-angle" 
TankTree["auto-tri-angle"] := "j|tri-angle" 
TankTree["surfer"] := "k|tri-angle" 
TankTree["eagle"] := "l|tri-angle" 
TankTree["phoenix"] := "m|tri-angle" 
TankTree["vulture"] := "n|tri-angle" 
TankTree["auto-5"] := "y|auto-3" 
TankTree["mega-3"] := "u|auto-3" 
TankTree["auto-4"] := "i|auto-3" 
TankTree["banshee"] := "h|auto-3" 
TankTree["bushwhacker"] := "y|trap guard" 
TankTree["gunner trapper"] := "u|trap guard" 
TankTree["bomber"] := "i|trap guard" 
TankTree["conqueror"] := "h|trap guard" 
TankTree["bulwark"] := "j|trap guard" 
TankTree["fortress"] := "y|tri-trapper" 
TankTree["hexa-trapper"] := "u|tri-trapper" 
TankTree["septa-trapper"] := "i|tri-trapper" 
TankTree["architect"] := "h|tri-trapper" 
TankTree["overlord"] := "y|overseer" 
TankTree["overtrapper"] := "u|overseer" 
TankTree["overgunner"] := "i|overseer" 
TankTree["banshee"] := "h|overseer" 
TankTree["auto-overseer"] := "j|overseer" 
TankTree["overdrive"] := "k|overseer" 
TankTree["commander"] := "l|overseer" 
TankTree["carrier"] := "y|cruiser" 
TankTree["battleship"] := "u|cruiser" 
TankTree["fortress"] := "i|cruiser" 
TankTree["auto-cruiser"] := "h|cruiser" 
TankTree["commander"] := "j|cruiser" 
TankTree["necromancer"] := "y|underseer" 
TankTree["maleficitor"] := "u|underseer" 
TankTree["infestor"] := "i|underseer" 
TankTree["factory"] := "y|spawner" 
TankTree["auto-spawner"] := "u|spawner" 
TankTree["conqueror"] := "y|destroyer" 
TankTree["annihilator"] := "u|destroyer" 
TankTree["hybrid"] := "i|destroyer" 
TankTree["constructor"] := "h|destroyer" 
TankTree["constructor"] := "y|builder" 
TankTree["auto-builder"] := "u|builder" 
TankTree["engineer"] := "i|builder" 
TankTree["boomer"] := "h|builder" 
TankTree["assembler"] := "j|builder" 
TankTree["architect"] := "k|builder" 
TankTree["conqueror"] := "l|builder" 
TankTree["mortar"] := "y|artillery" 
TankTree["ordnance"] := "u|artillery" 
TankTree["beekeeper"] := "i|artillery" 
TankTree["field gun"] := "h|artillery" 
TankTree["skimmer"] := "y|launcher" 
TankTree["twister"] := "u|launcher" 
TankTree["swarmer"] := "i|launcher" 
TankTree["sidewinder"] := "h|launcher" 
TankTree["field gun"] := "j|launcher" 
TankTree["constructor"] := "y|builder" 
TankTree["auto-builder"] := "u|builder" 
TankTree["engineer"] := "i|builder" 
TankTree["boomer"] := "h|builder" 
TankTree["assembler"] := "j|builder" 
TankTree["architect"] := "k|builder" 
TankTree["conqueror"] := "l|builder" 
TankTree["fortress"] := "y|tri-trapper" 
TankTree["hexa-trapper"] := "u|tri-trapper" 
TankTree["septa-trapper"] := "i|tri-trapper" 
TankTree["architect"] := "h|tri-trapper" 
TankTree["bushwhacker"] := "y|trap guard" 
TankTree["gunner trapper"] := "u|trap guard" 
TankTree["bomber"] := "i|trap guard" 
TankTree["conqueror"] := "h|trap guard" 
TankTree["bulwark"] := "j|trap guard" 
TankTree["triplex"] := "y|helix" 
TankTree["quadruplex"] := "u|helix" 
TankTree["mega-smasher"] := "y|smasher" 
TankTree["spike"] := "u|smasher" 
TankTree["auto-smasher"] := "i|smasher" 
TankTree["landmine"] := "h|smasher" 

UpdateSequenceArray(rawInput)

F6:: {
    global rawInput, isRunning, configFile
    
    if isRunning {
        isRunning := false
        SetTimer(ExecuteMacroLoop, 0)
        SendInput("{' up}")
    }
    
    userInput := InputBox("Enter the exact tank NAMES separated by COMMAS.`nLeave blank to run a pure Basic reset loop.`n`nFull setup example:`ndesmos, helix, quadruplex`n`nPounder setup example:`nannihilator, auto-builder, twister", "Arras.io Advanced Tank Macro Maker", "w450 h240", rawInput)
    
    if userInput.Result = "OK" {
        rawInput := userInput.Value
        
        try {
            if FileExist(configFile) {
                FileDelete(configFile)
            }
            FileAppend(rawInput, configFile, "UTF-8")
        }
        
        UpdateSequenceArray(rawInput)
        ToolTip("Configuration saved and macro compiled!")
        SetTimer(() => ToolTip(), -2000)
    }
}

F3:: {
    global isRunning, compiledMacroSequence
    
    if (compiledMacroSequence.Length = 0) {
        ToolTip("Erro: Sequência inválida! Pressione F6.")
        SetTimer(() => ToolTip(), -2000)
        return
    }
    
    isRunning := !isRunning

    if isRunning {
        ToolTip("MEGA-STACKER: LIGADO")
        SetTimer(() => ToolTip(), -1500)
        SetTimer(ExecuteMacroLoop, 1)
    } else {
        SetTimer(ExecuteMacroLoop, 0)
        SendInput("{' up}")
        ToolTip("MEGA-STACKER: DESATIVADO")
        SetTimer(() => ToolTip(), -1500)
    }
}


ExecuteMacroLoop() {
    global compiledMacroSequence
    Critical
    
    for keyCombo in compiledMacroSequence {
        SendInput("{' down}q{' up}" keyCombo)
        PreciseSleep(11)
    }
}

PreciseSleep(ms) {
    DllCall("kernel32\QueryPerformanceFrequency", "Int64*", &freq := 0)
    targetTicks := (ms / 1000) * freq
    DllCall("kernel32\QueryPerformanceCounter", "Int64*", &startTicks := 0)
    currentTicks := startTicks
    while ((currentTicks - startTicks) < targetTicks) {
        DllCall("kernel32\QueryPerformanceCounter", "Int64*", &currentTicks)
    }
}

; --- DYNAMIC PARSER AND REVERSE TREE TRACKER (WITH VALID BASIC OBJECT) ---
UpdateSequenceArray(inputStr) {
    global compiledMacroSequence, TankTree
    compiledMacroSequence := [] 
    
    ; If the input string is blank or cleared, treat it as a pure "basic" reset macro
    if (Trim(inputStr) == "") {
        inputStr := "basic"
    }
    
    Loop Parse, inputStr, "," {
        cleanName := StrLower(Trim(A_LoopField))
        
        if (cleanName == "")
            continue
            
        if TankTree.Has(cleanName) {
            pathKeys := ""
            currentNode := cleanName
            
            ; Reverse tracking loop moving upwards through the trees
            while (currentNode != "basic" && TankTree.Has(currentNode)) {
                nodeData := StrSplit(TankTree[currentNode], "|")
                
                pathKeys := nodeData[1] . pathKeys ; Pulls the literal hardware upgrade key
                currentNode := nodeData[2]          ; Shifts index to target parent node
            }
            
            compiledMacroSequence.Push(pathKeys)
        } else {
            ; Fallback route: allows manual string execution if keys match layout variations
            compiledMacroSequence.Push(cleanName)
        }
    }
}